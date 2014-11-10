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

        line = out.readlines[0]

        return success_notifer if proc.exit_code == 0
        failed_notifer line
      end

      def success_notifer
        ::Guard::Notifier.notify('Success', title: @options[:title], image: :success, priority: -2)
      end

      def failed_notifer(line)
        test_count, fail_count = 0, 0
        line.split("").each {|ch|
          p ch
          test_count += 1
          fail_count += 1 if ch == 'F'
        }
        p test_count
        p fail_count
        ::Guard::Notifier.notify("Failed #{test_count} tests, #{fail_count} failure", title: @options[:title], image: :failed, priority: 2)
      end
    end
  end
end
