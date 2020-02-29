module SimpleHttpServer
  # アプリケーション例外
  class ApplicationError < StandardError; end

  # リクエストパースエラー
  class InvalidRequestError < ApplicationError; end
end
