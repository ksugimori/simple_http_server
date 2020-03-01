module SimpleHttpServer
  # HTTP メッセージ関連のモジュール
  module Message
    # メッセージの改行文字
    CRLF = "\r\n"

    # 認識可能なHTTPメソッド
    HTTP_METHOD = [:get, :put, :post, :patch, :delete, :head]

    # リクエストラインをパースして HttpRequest オブジェクトを生成する
    # @param [String] request_line リクエストライン
    # @raise [InvalidRequestError] リクエストラインがパースできない場合
    # @return [HttpRequest] HTTPリクエスト
    def parse_request(request_line)
      m = /^(?<method>\S+) (?<target>\S+) (?<version>\S+)$/.match(request_line)

      raise InvalidRequestError, "cannot parse request line: #{request_line}" if m.nil?

      method = m[:method].downcase.to_sym
      target = m[:target]
      version = m[:version]

      HttpRequest.new(method, target, version)
    end

    module_function :parse_request

    # HTTP リクエスト
    class HttpRequest
      attr_reader :http_method, :target, :version

      # 初期化
      # @param [Symbol] http_method HTTPメソッド
      # @param [String] target ターゲットパス
      # @param [String] version HTTPバージョン
      def initialize(http_method, target, version)
        @http_method = http_method
        @target = target
        @version = version
      end
    end

    # HTTP レスポンス
    class HttpResponse
      attr_accessor :status, :body, :header, :version

      @@statuses = {
        ok: { code: 200, phrase: "OK" },
        bad_request: { code: 400, phrase: "Bad Request" },
        not_found: { code: 404, phrase: "Not Found" }
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
