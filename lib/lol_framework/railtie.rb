require "rails"

module LolFramework
  class Railtie < ::Rails::Railtie
    initializer "LolFramework.railtie" do |app|
      app.assets.prepend_path "#{LolFramework::Config::LOL_ASSETS_PATH}/images"
      app.assets.prepend_path "#{LolFramework::Config::LOL_ASSETS_PATH}/javascripts"
      app.assets.prepend_path "#{LolFramework::Config::LOL_ASSETS_PATH}/stylesheets"
    end

    config.after_initialize do
      LolFramework::Config.COMPONENTS_JS.generate
      LolFramework::Config.COMPONENTS_CSS.generate
    end
  end
end