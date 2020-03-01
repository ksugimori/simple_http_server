module SimpleHttpServer
  # HTTP リクエストの処理を行うハンドラ
  module Handler
    # HTTPリクエストを受け取り、処理結果をHTTPレスポンスとして返す
    # @param [HttpRequest] request HTTPリクエスト
    # @return [HttpResponse] HTTPレスポンス
    def handle(request)
      handler = handlerFactory(request.http_method)
      handler.handle(request)
    end

    # リクエストメソッドに応じたハンドラを返す
    # @param [Symbol] http_method HTTPメソッド
    # @return [RequestHandler] リクエストハンドラ
    def handlerFactory(http_method)
      case http_method
      when :get
        GetRequestHandler.new
      else
        raise MethodNotAllowedError
      end
    end

    module_function :handle, :handlerFactory
  end
end
