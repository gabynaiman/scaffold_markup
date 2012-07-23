module ScaffoldMarkup
  module Builders
    class BaseBuilder
      include TwitterBootstrapMarkup

      attr_reader :template
      attr_reader :block
      attr_reader :url

      def initialize(template, &block)
        @template = template
        @block = block
        @url = Helpers::UrlHelper.new(template)
      end

      def html_safe
        to_s.html_safe
      end

    end
  end
end
