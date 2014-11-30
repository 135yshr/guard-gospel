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
        out = Tempfile.new([options[:basename], options[:tempdir]])
        proc = ChildProcess.build @options[:cmd], 'test'

        proc.io.stdout = proc.io.stderr = out
        proc.cwd = Dir.pwd
        proc.start
        proc.wait

        out.open
        line = out.gets
        out.rewind
        STDOUT.write(out.read)
        out.close!
        out.unlink

        return success_notifer if proc.exit_code == 0
        failed_notifer line
      end

      def success_notifer
        ::Guard::Notifier.notify('Success', title: @options[:title], image: :success, priority: -2)
      end

      def failed_notifer(line)
        test_count, fail_count = 0, 0
        line.split("").each {|ch|
          if ch != 'F' && ch != '.'
            next
          end
          test_count += 1
          fail_count += 1 if ch == 'F'
        }
        ::Guard::Notifier.notify("Failed #{test_count} tests, #{fail_count} failure", title: @options[:title], image: :failed, priority: 2)
      end
    end
  end
end
