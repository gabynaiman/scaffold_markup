module ScaffoldMarkup
  module Builders
    class NavContainerBuilder < BaseBuilder

      def initialize(*args, &block)
        super(*args, &block)
        @container = NavContainer.new {}
      end

      def to_s
        template.capture(self, &block)
        @container.to_s
      end

      def link(*args, &block)
        @container.append Link.new(*args, &block)
      end

      def pull_right
        @container.pull_right
      end

      def capture(&block)
        @container.append super
      end

    end
  end
end