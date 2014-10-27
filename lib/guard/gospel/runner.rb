require 'childprocess'
require 'tempfile'

module Guard
  class Gospel
    class Runner
      attr_accessor :options, :pid

      def initialize(options = {})
        @options = options
      end

      def run
        proc = ChildProcess.build @options[:cmd], 'test'

        out = Tempfile.open(['go_spel', '.tmp'])
        out.sync = true

        proc.io.stdout = proc.io.stderr = out
        proc.cwd = Dir.pwd
        proc.start
        proc.wait

        return ::Guard::Notifier.notify('Success', title: @options[:title], image: :success, priority: -2) if proc.exit_code == 0
        ::Guard::Notifier.notify('Failed', title: @options[:title], image: :failed, priority: 2)
      end
    end
  end
end
