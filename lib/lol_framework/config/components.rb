require "lol_framework/config/components/js"
require "lol_framework/config/components/css"

module LolFramework
  module Config
    module Components
      def self.js
        @js ||= LolFramework::Config::Components::Js.new
      end

      def self.css
        @css ||= LolFramework::Config::Components::Css.new
      end
    end
  end
end