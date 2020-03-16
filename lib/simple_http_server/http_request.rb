require_relative "http_message"

module SimpleHttpServer
  # HTTP リクエスト
  class HttpRequest < HttpMessage
    attr_reader :http_method, :target, :version

    # 初期化
    # @param [Symbol] http_method HTTPメソッド
    # @param [String] target ターゲットパス
    # @param [String] version HTTPバージョン
    # @yield [HttpRequest] 初期化処理
    def initialize(http_method, target, version, &block)
      super()
      @http_method = http_method
      @target = target
      @version = version

      yield(self) if block_given?
    end
  end
end
