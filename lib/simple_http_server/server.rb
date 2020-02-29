require "socket"

module SimpleHttpServer
  # HTTP サーバ
  class Server
    def initialize(document_root)
      @document_root = document_root
    end

    # サーバを起動し、指定したポートで接続待ちを行う
    def listen(port)
      # 終了処理
      Signal.trap(:INT) { puts "Bye!"; exit! }

      puts "Server is starting on port #{port}"
      socket = TCPServer.open(port)

      loop do
        client = socket.accept

        # TODO 実際のハンドリング
        print client.gets

        client.close()
      end
    end
  end
end
