require "socket"

module SimpleHttpServer
  # HTTP サーバ
  class Server
    # 初期化処理
    # @param [String] document_root ドキュメントルートのパス
    def initialize(document_root)
      @document_root = document_root
      @logger = Logger.new
    end

    # サーバを起動し、指定したポートで接続待ちを行う。
    # 停止させる場合は Ctrl+C などで割り込みが必要です。
    # @param [Integer] port ポート番号
    def listen(port)
      @port = port

      # 終了処理
      Signal.trap(:INT) { shutdown() }

      socket = TCPServer.open(@port)
      startup_message()

      loop do
        Thread.start(socket.accept) do |client|
          Thread.current[:docroot] = @document_root
          begin
            request_line = client.gets&.chomp
            request = Parser.parse_request(request_line)
            response = Handler.handle(request)

            access_log(request, response)
            client.puts response.serialize
          rescue ApplicationError => e
            if e.is_a? MethodNotAllowedError
              response = HttpResponse.new(:method_not_allowed)
            else
              response = HttpResponse.new(:internal_server_error)
            end

            access_log(request, response)
            client.puts response.serialize
          ensure
            client.close
          end
        end
      end
    end

    # 起動時のメッセージを出力する
    def startup_message()
      puts "============================================="
      puts " simple http server ver. #{VERSION}"
      puts "---------------------------------------------"
      puts " document root: #{@document_root}"
      puts " port         : #{@port}"
      puts "============================================="
    end

    # 終了時のメッセージを表示し、サーバを停止する。
    def shutdown()
      puts
      puts "Bye!"
      exit!
    end

    # アクセスログを出力する。
    # @param [HttpRequest] request HTTPリクエスト
    # @param [HttpResponse] response HTTPレスポンス
    def access_log(request, response)
      request_line = "#{request.http_method.to_s.upcase} #{request.target} #{request.version}"
      status_line = "#{response.status_code} #{response.reason_phrase}"
      @logger.log(%Q{"#{request_line}" #{status_line}}, response.err)
    end
  end
end
