require_relative "http_message"

module SimpleHttpServer
  # HTTP レスポンス
  class HttpResponse < HttpMessage
    attr_accessor :status, :version, :err

    # 初期化
    # @param [Symbol] status HTTPステータス
    # @param [String] body レスポンスボディ
    # @param [String] version HTTPバージョン
    # @yield [HttpResponse] 初期化処理
    def initialize(status = :ok, body = nil, version = "HTTP/1.1", &block)
      super()
      @status = status
      @body = body
      @version = version

      yield(self) if block_given?
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
      header_lines.each do |line|
        result << line + CRLF
      end
      result << CRLF
      result << "#{@body}"
    end
  end
end
