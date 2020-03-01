require "simple_http_server"
require "thor"

module SimpleHttpServer
  # コマンドラインインターフェース
  class CLI < Thor
    option :port, :type => :numeric, :aliases => [:p], :banner => "<port>"
    option :docroot, :type => :string, :aliases => [:r], :banner => "<directory>"
    desc "start", "start server"
    # サーバを起動する
    def start()
      port = options[:port] || DEFAULT_PORT
      docroot = options[:docroot] || DEFAULT_DOCROOT

      server = Server.new(docroot)
      server.listen(port)
    end
  end
end
