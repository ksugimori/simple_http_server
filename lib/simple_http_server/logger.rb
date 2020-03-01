require "date"

module SimpleHttpServer

  # ロガー
  class Logger

    # タイムスタンプ付きのログを出力する。
    # @param [String] message メッセージ
    # @param [Error] err エラー
    def log(message, err = nil)
      puts "[#{Time.now}] #{message}"

      if err
        puts err
        puts err.backtrace
      end
    end
  end
end
