require "socket"
require "date"

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

    def access_log(request)
      puts "[#{Time.now}] #{request.http_method.to_s.upcase} #{request.target} #{request.version}"
    end
  end
end
