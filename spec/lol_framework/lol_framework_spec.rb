require "spec_helper"

describe LolFramework do
  describe "::version" do
    it "should have a version" do
      expect(LolFramework::VERSION).equal? "0.0.1"
    end

    it "should have a last date modified" do
      expect(LolFramework::UPDATED_AT).equal? "12-28-2012"
    end
  end
end