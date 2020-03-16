module SimpleHttpServer
  # HTTP メッセージのパーサ
  module Parser
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
