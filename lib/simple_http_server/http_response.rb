module SimpleHttpServer
  module Message
    # HTTP レスポンス
    class HttpResponse
      attr_accessor :status, :body, :header, :version, :err

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
        HTTP_STATUS[@status][:code]
      end

      # メッセージを取得する
      # @return [String] メッセージ
      def reason_phrase
        HTTP_STATUS[@status][:phrase]
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
