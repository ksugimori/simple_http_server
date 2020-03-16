require "forwardable"

module SimpleHttpServer
  # HTTP メッセージ
  # ヘッダやボディなどリクエストとレスポンスに共通するデータに関係する処理を規定します。
  class HttpMessage
    attr_accessor :body

    # ヘッダーの管理は Hash に移譲
    extend Forwardable
    def_delegators :@header, :[], :[]=
    def_delegator :@header, :each, :headers

    def initialize()
      @header = {}
    end

    # メッセージの改行文字
    CRLF = "\r\n"

    # 半角スペース
    SP = " "

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
