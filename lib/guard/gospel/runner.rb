require 'sys/proctable'
require 'childprocess'

module Guard
  class Gospel
  	class Runner
      attr_accessor :options, :pid

      def initialize(options = {})
      	@options = options
      end

      def run
        @proc = ChildProcess.build @options[:cmd], 'test'
        @proc.start
        @pid = @proc.pid
      end

      def ps_go_pid
        Sys::ProcTable.ps.select { |pe| pe.ppid == @pid }.map { |pe| pe.pid }
      end
  	end
  end
end