require 'rails/generators'
module ToauthConnect
  module Generators
    class AutomaticGenerator < Rails::Generators::Base
      source_root File.expand_path("../template", __FILE__)

      desc "Creates a TouthConnect initializer and copy locale files to your application."
      class_option :orm

      def add_gens
        gem 'devise'
        gem 'oauth2'
        gem 'rest-client'
        Bundler.with_clean_env do
          run "bundle install"
        end
      end
      
      def install_devise
         generate "devise:install"
      end

      def generate_toauth_user
        generate "toauth_connect:user"
      end

      def generate_toauth_connect
        generate "toauth_connect:config"
      end

    end
  end
end