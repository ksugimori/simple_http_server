require "socket"
require "date"

module SimpleHttpServer
  # HTTP サーバ
  class Server
    # 初期化処理
    # @param [String] document_root ドキュメントルートのパス
    def initialize(document_root)
      @document_root = document_root
    end

    # サーバを起動し、指定したポートで接続待ちを行う。
    # 停止させる場合は Ctrl+C などで割り込みが必要です。
    # @param [Integer] port ポート番号
    def listen(port)
      # 終了処理
      Signal.trap(:INT) { puts "Bye!"; exit! }

      socket = TCPServer.open(port)
      puts "Server is starting on port #{port}"

      loop do
        Thread.start(socket.accept) do |client|
          begin
            request_line = client.gets.chomp
            request = Message.parse_request(request_line)
            response = Handler.handle(request)

            access_log(request, response)

            client.puts response.serialize()
          rescue ApplicationError => e
            p e.backtrace
            Thread.exit
          ensure
            client.close
          end
        end
      end
    end

    # アクセスログを出力する。
    # @param [HttpRequest] request HTTPリクエスト
    # @param [HttpResponse] response HTTPレスポンス
    def access_log(request, response)
      request_line = "#{request.http_method.to_s.upcase} #{request.target} #{request.version}"
      puts %Q{[#{Time.now}] "#{request_line}" #{response.status_code} #{response.reason_phrase}}
    end
  end
end
