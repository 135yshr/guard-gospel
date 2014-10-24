require 'childprocess'

module Guard
  class Gospel
    class Runner
      attr_accessor :options, :pid

      def initialize(options = {})
        @options = options
      end

      def run
        proc = ChildProcess.build @options[:cmd], 'test'
        proc.start
        proc.wait

        return ::Guard::Notifier.notify('Success', title: @options[:title], image: :success, priority: -2) if proc.exit_code == 0
        ::Guard::Notifier.notify('Failed', title: @options[:title], image: :failed, priority: 2)
      end
    end
  end
end
