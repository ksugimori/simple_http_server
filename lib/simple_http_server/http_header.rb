require "forwardable"

module SimpleHttpServer
  module Message

    # HTTPヘッダ
    class HttpHeader
      extend Forwardable

      def_delegators :@hash, :[], :[]=

      # 初期化処理
      def initialize
        @hash = {}
      end

      # ヘッダー行のリストを作成する
      # @return [Array<String>] ヘッダー行文字列のリスト
      def lines
        @hash.map { |k, v| "#{k}: #{v}" }
      end
    end
  end
end
