module SimpleHttpServer
  module Handler
    # リクエストハンドラの基底クラス
    class RequestHandler; end

    # GET リクエストのハンドラ
    class GetRequestHandler < RequestHandler
      # リクエストを処理する。
      # ドキュメントルート以下のファイルを取得する。
      def handle(request)
        file_path = request.target
        begin
          data = File.read(file_path)
          response = Message::HttpResponse.new(:ok, data)
          response.header["Content-Type"] = "text/html"
          response.header["Content-Length"] = data.bytesize
          return response
        rescue StandardError => e
          e.backtrace
          return Message::HttpResponse.new(:not_found)
        end
      end
    end
  end
end
