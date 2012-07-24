module ScaffoldMarkup
  module Builders
    class PageBuilder < BaseBuilder
      include Helpers::LinkButtonHelper
      include Helpers::TableHelper

      def to_s
        html = template.capture(self, &block)
        flash_messages
        html
      end

      def container(attributes={}, &block)
        #TODO: Container tiene que ser un tag de TwitterBootstrapMarkup
        Tag.new(:div, template.capture(self, &block), attributes.prepend!(:class, 'container')).html_safe
      end

      def title(text)
        template.content_for(:page_title, text)
      end

      def header(title, subtitle=nil)
        template.content_for(:page_header, PageHeader.new(title, subtitle).html_safe)
      end

      def well_small(&block)
        Well.small(template.capture(self, &block)).html_safe
      end

      def submit_primary(*args)
        Submit.primary(*args).html_safe
      end

      def form_for(model, options={}, &block)
        FormBuilder.new(template, model, options, &block).html_safe
      end

      def nav_bar(&block)
        NavBarBuilder.new(template, &block).html_safe
      end

      def flash_messages
        unless template.content_for?(:flash)
          template.flash.keys.each do |key|
            if template.flash[key].is_a? Array
              flash_text = template.flash[key].join('<br>')
            else
              flash_text = template.flash[key]
            end
            template.content_for(:flash, self.send("alert_#{key}", flash_text))
          end
        end
      end

      Alert::TYPES.each do |type|
        define_method "alert_#{type}" do |content=nil, &block|
          Alert.send("#{type}_closable", content, &block).html_safe
        end
      end

    end
  end
end
