require 'tempfile'
require 'stringio'

module Guard
  class Gospel
    class Writer
      attr_accessor :options
      def initialize(options = {})
        @options = options
        @strio = StringIO.new
      end

      def write(text)
        STDOUT.write text
        @strio.write text
      end

      def to_io
        STDOUT
      end

      def string
        @strio.string
      end
    end
  end
end
