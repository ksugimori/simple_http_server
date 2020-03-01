require "singleton"

module SimpleHttpServer
  # アプリケーション全体で共有するコンテキスト
  class ApplicationContext
    include Singleton

    # 初期化処理
    # document_root は空文字が設定されます
    def initialize
      @document_root = ""
    end

    attr_accessor :document_root
  end
end
