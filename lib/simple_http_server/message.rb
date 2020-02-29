module SimpleHttpServer
  # HTTP メッセージ関連のモジュール
  module Message
    REQUEST_LINE_PATTERN = /^(?<method>\S+) (?<target>\S+) (?<version>\S+)$/
    CRLF = "\r\n"

    # リクエストラインをパースして Request オブジェクトを生成する
    def self.parse_request(request_line)
      m = REQUEST_LINE_PATTERN.match(request_line)

      raise ParseException, "cannot parse request line: #{request_line}" if m.nil?

      HttpRequest.new(m[:method], m[:target], m[:version])
    end

    # HTTP リクエスト
    class HttpRequest
      attr_reader :http_method, :request_uri, :version

      def initialize(http_method, request_uri, version)
        @http_method = http_method
        @request_uri = request_uri
        @version = version
      end
    end
  end
end
