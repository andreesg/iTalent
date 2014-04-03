require 'spec_helper'

describe "publications/show" do
  it "displays the publication" do
  	assign(:publication, build_stubbed(:publication, text: "0123: Publicacao ABC"))
  	render
  	expect(rendered).to include("0123: Publicacao ABC")
  end
end
