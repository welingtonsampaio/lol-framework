require "spec_helper"

describe LolFramework::Config::Components do
  before do
    @js = LolFramework::Config::Components.js
    @css = LolFramework::Config::Components.css
  end

  it "should be an object of type JS" do
    expect(@js).to be_an_instance_of LolFramework::Config::Components::Js
  end

  it "should be an object of type CSS" do
    expect(@css).to be_an_instance_of LolFramework::Config::Components::Css
  end

  it "should have a unique object_id for the object Js" do
    expect(@js.object_id).equal? LolFramework::Config::Components.js.object_id
  end

  it "should have a unique object_id for the object Css" do
    expect(@css.object_id).equal? LolFramework::Config::Components.css.object_id
  end
end