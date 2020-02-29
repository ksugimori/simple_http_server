require "simple_http_server"
require "thor"

module SimpleHttpServer
  # デフォルトポート
  DEFAULT_PORT = 3000

  # コマンドラインインターフェース
  class CLI < Thor
    option :port, :type => :numeric, :aliases => [:p], :banner => "<port>"
    option :docroot, :type => :string, :aliases => [:r], :banner => "<directory>"
    desc "start", "start server"
    # サーバを起動する
    def start()
      port = options[:port] || DEFAULT_PORT

      # TODO サーバ起動

      puts "port: #{port}"
    end
  end
end
