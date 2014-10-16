module Guard
  class GoSpel
    class Deprecator
      attr_accessor :options

      def self.warns_about_deprecated_options(options = {})
        new(options).warns_about_deprecated_options
      end

      def initialize(options = {})
      	@options = options
      end

      def warns_about_deprecated_options
      end
    end
  end
end