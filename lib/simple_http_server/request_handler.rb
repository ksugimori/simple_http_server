module SimpleHttpServer
  module Handler
    # リクエストハンドラの基底クラス
    class RequestHandler; end

    # GET リクエストのハンドラ
    class GetRequestHandler < RequestHandler
      # リクエストを処理する。
      # ドキュメントルート以下のファイルを取得する。
      def handle(request)
        # TODO: ファイル読み込み
        Message::HttpResponse.new(:not_found)
      end
    end
  end
end
