require 'rails/generators'
module ToauthConnect
  module Generators
    class AutomaticGenerator < Rails::Generators::Base
      source_root File.expand_path("../template", __FILE__)

      desc "Creates a TouthConnect initializer and copy locale files to your application."
      class_option :orm

      def copy_initializer
        template "toauth_connect.rb", "config/initializers/toauth_connect.rb"
      end

      def copy_controller
        template "toauth_controller.rb", "app/controllers/toauth_controller.rb"
      end

      def add_toauth_connect_routes    
        route  "get '/users/sign_in' => 'toauth#redirect'"
        route  "get 'toauth' => 'toauth#entrar'"
        route  "get 'auth/redirect' => 'toauth#redirect'"    
      end
    end
  end
end