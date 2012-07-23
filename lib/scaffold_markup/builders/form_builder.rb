module ScaffoldMarkup
  module Builders
    class FormBuilder < BaseBuilder
      attr_reader :model

      def initialize(template, model, &block)
        super(template, &block)
        @model = model
      end

      def to_s
        _self = self
        html = Form.horizontal(:method => :post, :action => model.new_record? ? url.list_resource(model.class) : url.resource(model), 'accept-charset' => 'UTF-8') do
          append Input.hidden :name => 'authenticity_token', :value => _self.template.form_authenticity_token
          append Input.hidden :name => '_method', :value => :put unless _self.model.new_record?
          append _self.template.capture(_self, &_self.block)
        end.to_s
        flash_errors
        html
      end

      def display(attribute)
        association = model.class.reflected_association(attribute)
        display_value = association ? model.send(association.name).to_s : model.send(attribute)
        ControlGroup.new(model.class.human_attribute_name(attribute), :class => 'bold') do
          append Tag.block(:span, display_value, :class => 'display')
        end.html_safe
      end

      def text(attribute, options={})
        _self = self
        ControlGroup.new("#{model.class.human_attribute_name(attribute)}#{options[:required] ? ' (*)' : ''}", :class => options[:required] ? 'bold' : '') do
          text_box = append Input.text(:id => "#{_self.model.class.model_name.underscore}_#{attribute}", :name => "#{_self.model.class.model_name.underscore}[#{attribute}]", :value => _self.model.send(attribute))
          text_box.attributes[:required] = :required if options[:required]
        end.html_safe
      end

      def association(association_name, options={})
        _self = self
        attribute = model.class.reflections[association_name].foreign_key
        ControlGroup.new("#{model.class.human_attribute_name(association_name)}#{options[:required] ? ' (*)' : ''}", :class => options[:required] ? 'bold' : '') do
          html_attributes = {
              :prompt => '[Select]',
              :selected_value => _self.model.send(attribute),
              :id => "#{_self.model.class.model_name.underscore}_#{attribute}",
              :name => "#{_self.model.class.model_name.underscore}[#{attribute}]"
          }
          select = append Select.new(Hash[_self.model.class.reflections[association_name].klass.all.map { |e| [e.to_s, e.id] }], html_attributes)
          select.attributes[:required] = :required if options[:required]
        end.html_safe
      end

      def actions(&block)
        #TODO: FormActions tiene que ser una clase de TwitterBootstrapMarkup
        Tag.block(:div, template.capture(self, &block), :class => 'form-actions').html_safe
      end

      def flash_errors
        _self = self
        if model.errors.any?
          errors = Alert.danger_closable do
            append Tag.block(:strong, 'Cant perform requested operation')
            append do
              Tag.block(:ul) do
                _self.model.errors.full_messages.each do |msg|
                  append Tag.new(:li, msg.gsub(/\n/, '<br>'))
                end
              end
            end
          end
          template.content_for(:flash, errors.html_safe)
        end
      end

    end
  end
end