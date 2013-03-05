require "spec_helper"

describe LolFramework::Config do
  describe "::LOL_ASSETS_PATH" do
    it "should contain the absolute walks to the folder of assets" do
      expect(LolFramework::Config::LOL_ASSETS_PATH).equal? File.expand_path('../../../assets', __FILE__)
    end
  end

  describe "instance methods" do
    it "should return an object Js" do
      expect(LolFramework::Config.COMPONENTS_JS).to be_an_instance_of LolFramework::Config::Components::Js
    end

    it "should return an object Css" do
      expect(LolFramework::Config.COMPONENTS_CSS).to be_an_instance_of LolFramework::Config::Components::Css
    end
  end
end