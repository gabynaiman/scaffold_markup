module ScaffoldMarkup
  module Helpers
    module TableHelper
      include TwitterBootstrapMarkup

      def table(collection, attributes, options={})
        _self = self

        column_names = collection.is_a?(ActiveRecord::Relation) ? attributes.map { |a| collection.klass.human_attribute_name(a) } : attributes
        column_names.insert(0, '') if options[:actions]

        html = Table.striped.condensed do
          append _self.table_head(column_names)
          append _self.table_body(collection, attributes, options[:actions] || [])
        end.to_s

        if collection.respond_to?(:current_page)
          html << Tag.new(:div, template.paginate(collection, :theme => 'twitter_bootstrap')).pull_right.to_s
        end

        html.html_safe
      end

      def table_head(attribute_names)
        Tag.new(:thead) do
          append do
            Tag.new(:tr) do
              attribute_names.each do |name|
                append Tag.new(:th, name)
              end
            end
          end
        end.html_safe
      end

      def table_body(collection, attributes, actions=[])
        _self = self
        Tag.new(:tbody) do
          collection.each do |element|
            append do
              Tag.new(:tr) do
                append Tag.new(:td, _self.table_actions(actions, element), :class => 'actions')
                attributes.each do |attribute|
                  append Tag.new(:td, element.send(attribute))
                end
              end
            end
          end
        end.html_safe
      end

      def table_actions(actions, element)
        _self = self
        #TODO: DropdownButton tiene que soportar no recibir texto y dejar en blanco por default
        DropdownButton.mini('') do
          actions.each do |action|
            case action
              when :show
                #TODO: El append de DropdownButton tiene que soportar bloques como parametro
                append(Link.new(_self.url.resource(element, _self.template.controller_namespace)) do
                  append Icon.new('list')
                  append '&nbsp;Show'
                end)
              when :edit
                append(Link.new(_self.url.edit_resource(element, _self.template.controller_namespace)) do
                  append Icon.new('pencil')
                  append '&nbsp;Edit'
                end)
              when :remove
                append(Link.new(_self.url.resource(element, _self.template.controller_namespace), 'data-confirm' => 'Are you sure?', 'data-method' => :delete) do
                  append Icon.new('trash')
                  append '&nbsp;Remove'
                end)
              else
                append action
            end
          end
        end.html_safe
      end

    end
  end
end