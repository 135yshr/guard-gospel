require 'stringio'

module Guard
  class Gospel
    class Writer < IO
      def initialize
        @sio = StringIO.new
      end

      def write(text)
        STDOUT.write text
        @sio.write text
      end

      def to_io
        self
      end

      def readlines
        @sio.readlines
      end
    end
  end
end
