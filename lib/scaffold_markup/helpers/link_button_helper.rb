module ScaffoldMarkup
  module Helpers
    module LinkButtonHelper
      include TwitterBootstrapMarkup

      def link_button(*args, &block)
        LinkButton.new(*args, &block).html_safe
      end

      ButtonBase::TYPES.each do |type|
        define_method("link_button_#{type}") do |*args, &block|
          LinkButton.send(type, *args, &block).html_safe
        end
      end

      ButtonBase::SIZES.each do |size|
        define_method("link_button_#{size}") do |*args, &block|
          LinkButton.send(size, *args, &block).html_safe
        end
      end

      ButtonBase::TYPES.each do |type|
        ButtonBase::SIZES.each do |size|
          define_method("link_button_#{type}_#{size}") do |*args, &block|
            LinkButton.send("#{type}_#{size}", *args, &block).html_safe
          end
        end
      end

    end
  end
end