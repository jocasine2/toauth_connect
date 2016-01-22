require 'rails/generators'
module ToauthConnect
  module Generators
    class AutomaticGenerator < Rails::Generators::Base
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