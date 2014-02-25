require 'rails/generators/base'
require 'securerandom'

module AngularValidationsRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      #desc 'Copy the config file to handle model validations with AngularJS.'

      #def copy_initializer
      #  template 'afv.yml', 'config/afv.yml'
      #end

      desc 'Include styles'

      def include_style
        original_css = File.binread('app/assets/stylesheets/application.css')
        if original_css.include?("require 'angular_validations_rails'")
          say_status('skipped', 'insert into app/assets/stylesheets/application.css', :yellow)
        else
          insert_into_file 'app/assets/stylesheets/application.css', :after => %r{\*= require_self} do
            "\n *= require 'angular_validations_rails'"
          end
        end
      end
    end
  end
end