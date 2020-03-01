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
          file_path = File.join(file_path, "index.html") if File.directory? file_path
          data = File.read(file_path)
          response = Message::HttpResponse.new(:ok, data)
          response.header["Content-Type"] = "text/html"
          response.header["Content-Length"] = data.bytesize
        rescue Errno::ENOENT
          # ファイルが存在しない場合は 404
          response = Message::HttpResponse.new(:not_found)
        rescue StandardError => err
          # その他は 500
          response = Message::HttpResponse.new(:internal_server_error)
          response.err = err
        end

        return response
      end
    end
  end
end
