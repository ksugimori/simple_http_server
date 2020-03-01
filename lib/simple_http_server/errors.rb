module SimpleHttpServer
  # アプリケーション例外
  class ApplicationError < StandardError; end

  # リクエストパースエラー
  class InvalidRequestError < ApplicationError; end

  # ファイルが見つからない場合のエラー
  class FileNotFoundError < ApplicationError; end
end
