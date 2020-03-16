require "forwardable"

module SimpleHttpServer
  # HTTP メッセージ
  class HttpMessage
    attr_accessor :body
    extend Forwardable

    # ヘッダーの管理は Hash に移譲
    def_delegators :@hash, :[], :[]=

    def initialize()
      @hash = {}
    end

    # ヘッダー行のリストを作成する
    # @return [Array<String>] ヘッダー行文字列のリスト
    def header_lines
      @hash.map { |k, v| "#{k}: #{v}" }
    end

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
  end
end
