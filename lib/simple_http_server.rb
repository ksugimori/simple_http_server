require "simple_http_server/version"
require "simple_http_server/logger"
require "simple_http_server/errors"
require "simple_http_server/message"
require "simple_http_server/http_header"
require "simple_http_server/http_request"
require "simple_http_server/http_response"
require "simple_http_server/parser"
require "simple_http_server/server"
require "simple_http_server/request_handler"
require "simple_http_server/handler"
require "simple_http_server/cli"

# Ruby, HTTP 学習用のHTTPサーバ
# @author ksugimori
module SimpleHttpServer
  class Error < StandardError; end

  # デフォルトポート
  DEFAULT_PORT = 3000

  # デフォルトのドキュメントルート
  DEFAULT_DOCROOT = "/var/www"

  # Your code goes here...
end
