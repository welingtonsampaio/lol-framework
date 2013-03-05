require "lol_framework/config/components"

module LolFramework
  module Config

    LOL_ASSETS_PATH = File.expand_path("../../../vendor/assets", __FILE__)

    def self.COMPONENTS_JS
      LolFramework::Config::Components.js
    end

    def self.COMPONENTS_CSS
      LolFramework::Config::Components.css
    end

  end
end
