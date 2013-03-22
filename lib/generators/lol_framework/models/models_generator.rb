require 'rails'
require 'generators/backbone/resource_helpers'

module LolFramework
  module Generators
    class ModelsGenerator < ::Rails::Generators::Base
      include Backbone::Generators::ResourceHelpers

      desc "This command will prepare the system for working with models javascripts in standard backbone"
      source_root File.expand_path('../templates', __FILE__)

      def inject_backbone
        if File.exists? "app/assets/javascripts/application.js"
          inject_into_file "app/assets/javascripts/application.js", :after => "//= require lol" do
            "\n//= require backbone/#{application_name.underscore}"
          end
          inject_into_file "app/assets/javascripts/application.js" do
            "\n\nLol.model.reference = #{js_app_name}.Models;"
          end
        end
        if File.exists? "app/assets/javascripts/application.js.coffee"
          inject_into_file "app/assets/javascripts/application.js.coffee", :after => "#= require lol" do
            "\n#= require backbone/#{application_name.underscore}"
          end
          inject_into_file "app/assets/javascripts/application.js.coffee", :after => "#= require_self" do
            "\n\nLol.model.reference = #{js_app_name}.Models"
          end
        end
      end

      def create_dir_layout
        %W{models}.each do |dir|
          empty_directory "app/assets/javascripts/backbone/#{dir}"
        end
      end

      def create_app_file
        template "app.coffee", "app/assets/javascripts/backbone/#{application_name.underscore}.js.coffee"
      end

    end
  end
end
