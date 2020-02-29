module SimpleHttpServer
  # HTTP メッセージ関連のモジュール
  module Message
    REQUEST_LINE_PATTERN = /^(?<method>\S+) (?<target>\S+) (?<version>\S+)$/
    CRLF = "\r\n"

    HTTP_METHOD = [:get, :put, :post, :patch, :delete, :head]

    # リクエストラインをパースして Request オブジェクトを生成する
    def self.parse_request(request_line)
      m = REQUEST_LINE_PATTERN.match(request_line)

      raise ParseException, "cannot parse request line: #{request_line}" if m.nil?

      method = m[:method].downcase.to_sym
      target = m[:target]
      version = m[:version]

      HttpRequest.new(method, target, version)
    end

    # HTTP リクエスト
    class HttpRequest
      attr_reader :http_method, :target, :version

      def initialize(http_method, target, version)
        @http_method = http_method
        @target = target
        @version = version
      end
    end
  end
end
