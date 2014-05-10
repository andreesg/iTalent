require "spec_helper"

describe "routes for Likes" do
  it "routes /publications/:publication_id/like do the Likes controller" do
    { :destroy => "/publications/like"}.should
      route_to(controller: "cenas", action: "destroy")
  end
end
