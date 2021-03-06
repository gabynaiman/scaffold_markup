module ScaffoldMarkup
  module Helpers
    class UrlHelper
      attr_reader :template

      def initialize(template)
        @template = template
      end

      def list_resource(model_class, controller_namespace=nil)
        template.send "#{controller_namespace ? "#{controller_namespace}_" : ''}#{model_class.model_name.underscore.pluralize}_path"
      end

      def resource(model_instance, controller_namespace=nil)
        template.send "#{controller_namespace ? "#{controller_namespace}_" : ''}#{model_instance.class.model_name.underscore}_path", model_instance.id
      end

      def new_resource(model_class, controller_namespace=nil)
        template.send "new_#{controller_namespace ? "#{controller_namespace}_" : ''}#{model_class.model_name.underscore}_path"
      end

      def edit_resource(model_instance, controller_namespace=nil)
        template.send "edit_#{controller_namespace ? "#{controller_namespace}_" : ''}#{model_instance.class.model_name.underscore}_path", model_instance.id
      end

    end
  end
end