module SimpleHttpServer
  # HTTP リクエスト
  class HttpRequest < Message
    attr_reader :http_method, :target, :version

    # 初期化
    # @param [Symbol] http_method HTTPメソッド
    # @param [String] target ターゲットパス
    # @param [String] version HTTPバージョン
    # @yield [HttpRequest] 初期化処理
    def initialize(http_method, target, version, &block)
      @http_method = http_method
      @target = target
      @version = version
      @header = HttpHeader.new

      yield(self) if block_given?
    end
  end
end
