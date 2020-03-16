module SimpleHttpServer
  module Message
    # HTTP レスポンス
    class HttpResponse
      attr_accessor :status, :body, :header, :version, :err

      @@statuses = {
        ok: { code: 200, phrase: "OK" },
        bad_request: { code: 400, phrase: "Bad Request" },
        not_found: { code: 404, phrase: "Not Found" },
        method_not_allowed: { code: 405, phrase: "Method Not Allowed" },
        internal_server_error: { code: 500, phrase: "Internal Server Error" }
      }

      # 初期化
      # @param [Symbol] status HTTPステータス
      # @param [String] body レスポンスボディ
      # @param [String] version HTTPバージョン
      def initialize(status = :ok, body = nil, version = "HTTP/1.1")
        @status = status
        @body = body
        @version = version
        @header = HttpHeader.new
      end

      # ステータスコードを取得する
      # @return [Integer] ステータスコード
      def status_code
        @@statuses[@status][:code]
      end

      # メッセージを取得する
      # @return [String] メッセージ
      def reason_phrase
        @@statuses[@status][:phrase]
      end

      # シリアライズする
      # @return レスポンス文字列
      def serialize()
        result = "#{@version} #{status_code} #{reason_phrase}" + CRLF
        @header.lines.each do |line|
          result << line + CRLF
        end
        result << CRLF
        result << "#{@body}"
      end
    end
  end
end
