require 'rails'

module LolFramework
  module Generators
    class SetupGenerator < ::Rails::Generators::Base

      desc "This generator creates the file 'lol_framework.rb' which is responsible for the modules to be used"
      source_root File.expand_path('../', __FILE__)

      def create_initializer
        say_status("create", "lol_framework.rb initializer", :green)
        copy_file "lol_framework.rb", "config/initializers/lol_framework.rb"
      end

    end
  end
end
