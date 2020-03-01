module SimpleHttpServer
  module Handler
    # リクエストハンドラの基底クラス
    class RequestHandler; end

    # GET リクエストのハンドラ
    class GetRequestHandler < RequestHandler
      @@mime_type = {
        ".txt" => "text/plain",
        ".htm" => "text/html",
        ".html" => "text/html",
        ".css" => "text/css",
        ".js" => "text/javascript",
        ".json" => "application/json",
        ".ico" => "image/vnd.microsoft.icon",
        ".gif" => "image/gif",
        ".jpeg" => "image/jpeg",
        ".jpg" => "image/jpeg",
        ".png" => "image/png"
      }

      # リクエストを処理する。
      # ドキュメントルート以下のファイルを取得する。
      def handle(request)
        begin
          context = ApplicationContext.instance
          file_path = File.join(context.document_root, request.target)

          file_path = index_file_if_directory(file_path)

          data = File.read(file_path)

          response = Message::HttpResponse.new(:ok, data)
          response.header["Content-Type"] = mime_type_of(file_path)
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

      # ファイルの拡張子に対応した MIME Type を返します。
      # @param [String] file_path ファイルパス
      # @return MIME type
      def mime_type_of(file_path)
        @@mime_type[File.extname(file_path)] || "text/plain"
      end

      # パスがディレクトリであればインデックスファイルを追加する。
      # @param [String] file_path ファイルパス
      # @return [String] インデックスファイル名が付与されたパス。入力がディレクトリではない場合は入力そのまま
      def index_file_if_directory(file_path)
        if File.directory? file_path
          File.join(file_path, "index.html")
        else
          file_path
        end
      end
    end
  end
end
