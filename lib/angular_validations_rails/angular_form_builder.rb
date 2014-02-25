require 'action_view/helpers/form_helper'
class AngularFormBuilder < ActionView::Helpers::FormBuilder
  def self.create_tagged_field(method_name)
    define_method(method_name) do |label, *args|
      options = args.extract_options!
      options.merge!(afv_field_validators(@object, label))
      super(label, *(args << options))
    end

  end
  field_helpers.each do |name|
    create_tagged_field(name)
  end

  def submit(value=nil, options={})
    options.merge!(afv_form_submit(@object))
    super(value, options)
  end

  private

  def afv_form_submit(model)
    {'ng-disabled' => "#{model.class.to_s.downcase}_form.$invalid"}
  end

  def afv_form_name (model)
    "#{model.to_s.downcase}_form"
  end

  def afv_field_validators(model, field_name)
    options = {'ng-model' => "#{model.class.to_s.downcase}.#{field_name.to_s}"}
    #field_name_to_look_up = field_name.to_s.gsub(/_confirmation/,'').to_sym
    field_validations = model.class.validations.select{|i| i[:field_name]==field_name}

    field_validations.each do |validation|
      case validation[:class]
        when 'PresenceValidator' then
          options['required'] = 'required'
        when 'FormatValidator' then
          options['ng-pattern'] = "/#{validation[:options][:with].source}/i"
        when 'LengthValidator' then
          options['ng-minlength'] = validation[:options][:minimum] if validation[:options].has_key?(:minimum)
          options['ng-maxlength'] = validation[:options][:maximum] if validation[:options].has_key?(:maximum)
          options['ng-minlength'] = options['ng-maxlength'] = validation[:options][:is] if validation[:options].has_key?(:is)
          if validation[:options].has_key?(:in)
            values = validation[:options][:in].split('..')
            options['ng-minlength'] = values[0]
            options['ng-maxlength'] = values[1]
          end
        when 'ConfirmationValidator' then
          options['ng-match'] = "#{model.class.to_s.downcase}.#{field_name.to_s.gsub(/_confirmation/,'')}"
        #when 'AcceptanceValidator' then
      end
    end
    options
  end
end