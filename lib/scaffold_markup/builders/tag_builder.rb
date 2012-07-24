module ScaffoldMarkup
  module Builders
    class TagBuilder

      def method_missing(method, *args, &block)
        TwitterBootstrapMarkup::TagBuilder.send(method, *args, &block).to_s.html_safe
      end

    end
  end
end