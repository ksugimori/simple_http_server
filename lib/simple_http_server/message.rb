module SimpleHttpServer
  # HTTP メッセージ関連のモジュール
  module Message
    # メッセージの改行文字
    CRLF = "\r\n"

    # 認識可能なHTTPメソッド
    HTTP_METHOD = [:get, :put, :post, :patch, :delete, :head]

    # HTTP ステータス
    HTTP_STATUS = {
      ok: { code: 200, phrase: "OK" },
      bad_request: { code: 400, phrase: "Bad Request" },
      not_found: { code: 404, phrase: "Not Found" },
      method_not_allowed: { code: 405, phrase: "Method Not Allowed" },
      internal_server_error: { code: 500, phrase: "Internal Server Error" }
    }

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
  end
end
