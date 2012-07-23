module ScaffoldMarkup
  module Helpers
    class UrlHelper
      attr_reader :template

      def initialize(template)
        @template = template
      end

      def list_resource(model_class)
        template.send "#{model_class.model_name.underscore.pluralize}_path"
      end

      def resource(model_instance)
        template.send "#{model_instance.class.model_name.underscore}_path", model_instance.id
      end

      def new_resource(model_class)
        template.send "new_#{model_class.model_name.underscore}_path"
      end

      def edit_resource(model_instance)
        template.send "edit_#{model_instance.class.model_name.underscore}_path", model_instance.id
      end

    end
  end
end