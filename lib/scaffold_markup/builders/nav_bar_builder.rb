module ScaffoldMarkup
  module Builders
    class NavBarBuilder < BaseBuilder

      def to_s
        _self = self
        NavBar.top do
          append _self.template.capture(_self, &_self.block)
        end.to_s
      end

      def brand(text, url)
        Brand.new(text, url).html_safe
      end

      def container(&block)
        NavContainerBuilder.new(template, &block).html_safe
      end

      def link(text, url)
        Link.new(text, url).html_safe
      end

    end
  end
end