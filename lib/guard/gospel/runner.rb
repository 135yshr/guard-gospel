require 'childprocess'

module Guard
  class GoSpel
  	class Runner
      attr_accessor :options, :pid

      def initialize(options = {})
      	@options = options
      end

      def run()
        @proc = ChildProcess.build(@options[:cmd], 'test')
        @proc.start
        @pid = @proc.pid
      end

      def ps_go_pid()
        1
      end
  	end
  end
end