module ModelValidators
  module ClassMethods
    def validations
      items = validators.map{|v| {class: v.class.to_s.split('::').last, field_name: v.attributes.first, options: v.options}}
      items.select{|i| i[:class]=='ConfirmationValidator'}.each do |item|
        item[:field_name] = "#{item[:field_name]}_confirmation".to_sym
      end
      items
    end
  end
  def self.included(base)
    base.extend(ClassMethods)
  end
end