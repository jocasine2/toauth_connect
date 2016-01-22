require 'rails/generators'
module ToauthConnect
  module Generators
    class InstallGenerator < Rails::Generators::Base
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
    class AutoGenerator < Rails::Generators::Base
      def add_gens
        gem 'devise'
        gem 'oauth2'
        gem 'rest-client'
      end
      
      def create_user_table
        generate "scaffold", "user name cpf token"
      end

      def install_devise
         generate "devise:install"
      end

      def install_devise
         generate "devise",  "user"
      end

      def run_rake
        rake "db:migrate"
      end

      def generate_toauth_connect
        generate "toauth_connect"
      end

      def add_user_method
        inject_into_class 'app/model/user.rb', "User", <<-'RUBY'
          def toauth_fast
            ToauthConnect.fastdata(self)
          end

          def toauth_data
            ToauthConnect.profile_data(self)
          end
        RUBY
        end
      end
    end
  end
end