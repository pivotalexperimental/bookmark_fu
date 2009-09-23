require File.dirname(__FILE__) + '/../bookmark_fu_spec_helper'

module BookmarkFu
describe Configuration, ".to_yaml" do
  before do
    Configuration.all_services.should_not be_empty
  end

  it "creates yaml for all services without the namespaces" do
    Configuration.to_yaml.should == [
      "Delicious",
      "Reddit",
      "Digg",
      "NewsVine",
      "Delirious",
      "Blinkbits",
      "BlinkList",
      "Blogmarks",
      "Comments",
      "Fark",
      "Furl",
      "Magnolia",
      "Netvouz",
      "Scuttle",
      "Shadows",
      "Simpy",
      "TailRank",
      "YahooMyWeb",
      "StumbleUpon",
      "Facebook"
    ].to_yaml
  end
end
end