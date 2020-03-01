module SimpleHttpServer
  # HTTP メッセージ関連のモジュール
  module Message
    # 認識可能なHTTPメソッド
    HTTP_METHOD = [:get, :put, :post, :patch, :delete, :head]

    # リクエストラインをパースして HttpRequest オブジェクトを生成する
    # @param [String] リクエストライン
    # @raise [InvalidRequestError] リクエストラインがパースできない場合
    # @return [HttpRequest] HTTPリクエスト
    def self.parse_request(request_line)
      m = /^(?<method>\S+) (?<target>\S+) (?<version>\S+)$/.match(request_line)

      raise InvalidRequestError, "cannot parse request line: #{request_line}" if m.nil?

      method = m[:method].downcase.to_sym
      target = m[:target]
      version = m[:version]

      HttpRequest.new(method, target, version)
    end

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
      attr_reader :status, :body

      @@statuses = {
        ok: { code: 200, phrase: "OK" },
        bad_request: { code: 400, phrase: "Bad Request" }
      }

      # 初期化
      # @param [Symbol] status HTTPステータス
      def initialize(status = :ok)
        @status = status
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
    end
  end
end
