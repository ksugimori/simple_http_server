module SimpleHttpServer
  module Handler
    # リクエストハンドラの基底クラス
    class RequestHandler; end

    # GET リクエストのハンドラ
    class GetRequestHandler < RequestHandler
      # リクエストを処理する。
      # ドキュメントルート以下のファイルを取得する。
      def handle(request)
        context = ApplicationContext.instance
        file_path = File.join(context.document_root, request.target)
        begin
          data = File.read(file_path)
          response = Message::HttpResponse.new(:ok, data)
          response.header["Content-Type"] = "text/html"
          response.header["Content-Length"] = data.bytesize
          return response
        rescue Errno::ENOENT
          # ファイルが存在しない場合は 404
          return Message::HttpResponse.new(:not_found)
        rescue StandardError
          # その他は 500
          return Message::HttpResponse.new(:internal_server_error)
        end
      end
    end
  end
end
