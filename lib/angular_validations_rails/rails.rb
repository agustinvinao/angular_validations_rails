require 'angular_validations_rails/model_validators'
require 'angular_validations_rails/angular_form_builder'
module AngularValidationsRails
  class Engine < ::Rails::Engine
    config.angular_validations_rails = AngularValidationsRails

    initializer 'angular_validations_rails.load_config' do
      afv_config_file = File.join(Rails.root,'config','afv.yml')
      afv_config = YAML.load_file(afv_config_file)[Rails.env].symbolize_keys

      AngularValidation.configure do |config|
        config.models               = afv_config[:models]
        config.ng_application_name  = afv_config[:ng_application] if afv_config[:ng_application]
        config.ng_controller_name   = afv_config[:ng_controller]  if afv_config[:ng_controller]
      end

      afv_config[:models].each do |model|
        model.constantize.send :include, ModelValidators
      end

      #config.assets.precompile += %w(angular_validations_rails.css)
      #app.
    end

  end
end
