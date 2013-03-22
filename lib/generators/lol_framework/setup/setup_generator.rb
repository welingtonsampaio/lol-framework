require 'rails'

module LolFramework
  module Generators
    class SetupGenerator < ::Rails::Generators::Base

      desc "This generator creates the file 'lol_framework.rb' which is responsible for the modules to be used"
      source_root File.expand_path('../templates', __FILE__)

      def inject_stylesheet
        if File.exists? "app/assets/stylesheets/application.css"
          inject_into_file "app/assets/stylesheets/application.css", :before => " *= require_self" do
            " *= require bootstrap\n *= require bootstrap-responsive\n *= require lol\n"
          end
        end
        if File.exists? "app/assets/stylesheets/application.scss"
          inject_into_file "app/assets/stylesheets/application.scss", :before => "//= require_self" do
            "//= require bootstrap\n//= require bootstrap-responsive\n//= require lol\n"
          end
        end
      end

      def inject_javascript
        if File.exists? "app/assets/javascripts/application.js"
          inject_into_file "app/assets/javascripts/application.js", :before => "//= require_self" do
            "//= require jquery\n//= require bootstrap\n//= require lol\n"
          end
        end
        if File.exists? "app/assets/javascripts/application.js.coffee"
          inject_into_file "app/assets/javascripts/application.js.coffee", :before => "#= require_self" do
            "#= require jquery\n#= require bootstrap\n#= require lol\n"
          end
        end
      end

      def create_initializer
        copy_file "lol_framework.rb", "config/initializers/lol_framework.rb"
      end

    end
  end
end
