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
        @proc.wait
        @pid = @proc.pid
        if @proc.exit_code == 0 then
          ::Guard::Notifier.notify('Success', title: @options[:title], image: :success, priority: -2)
        end
      end

      def ps_go_pid
        Sys::ProcTable.ps.select { |pe| pe.ppid == @pid }.map { |pe| pe.pid }
      end
    end
  end
end
