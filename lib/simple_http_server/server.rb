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

      puts "Server is starting on port #{port}"
      socket = TCPServer.open(port)

      loop do
        Thread.start(socket.accept) do |client|
          begin
            request_line = client.gets.chomp
            request = Message.parse_request(request_line)
            access_log(request)
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
    def access_log(request)
      puts "[#{Time.now}] #{request.http_method.to_s.upcase} #{request.target} #{request.version}"
    end
  end
end
