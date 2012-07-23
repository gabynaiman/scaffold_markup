class ActiveRecord::Base
  def self.reflected_association(attribute)
    reflections.map { |k, v| v }.select { |e| e.foreign_key == attribute.to_s }.first
  end

  def self.accessible_attribute_names
    accessible_attributes.to_a.select { |a| a.present? }
  end

  def self.validates_presence?(attribute)
    validator = validators.select { |v| v.is_a?(ActiveModel::Validations::PresenceValidator) }.first
    validator && (validator.attributes.include?(attribute.to_sym) || validator.attributes.include?(attribute.to_s))
  end
end