module SimpleHttpServer
  module Message
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
  end
end
