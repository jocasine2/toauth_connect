require 'rails/generators/base'
module Devise
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a TouthConnect initializer and copy locale files to your application."
      class_option :orm

      def copy_initializer
        template "toauth_connect.rb", "config/initializers/toauth_connect.rb"
      end
    end
  end
end