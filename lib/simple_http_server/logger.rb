require "date"
require "rainbow"

module SimpleHttpServer

  # ロガー
  class Logger

    # タイムスタンプ付きのログを出力する。
    # @param [String] message メッセージ
    # @param [Error] err エラー
    def log(message, err = nil)
      puts "[#{Rainbow(Time.now).cyan}] #{message}"

      if err
        puts Rainbow(err).red
        puts Rainbow(err.backtrace).red
      end
    end
  end
end
