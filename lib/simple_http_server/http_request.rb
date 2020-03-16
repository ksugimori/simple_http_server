module SimpleHttpServer
  module Message
    # HTTP リクエスト
    class HttpRequest
      attr_reader :http_method, :target, :version, :header
      attr_accessor :body

      # 初期化
      # @param [Symbol] http_method HTTPメソッド
      # @param [String] target ターゲットパス
      # @param [String] version HTTPバージョン
      def initialize(http_method, target, version, &block)
        @http_method = http_method
        @target = target
        @version = version
        @header = HttpHeader.new
        @body = nil

        yield(self) if block_given?
      end
    end
  end
end
