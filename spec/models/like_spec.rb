require 'spec_helper'

describe Like do
  
  before do
    @like = build_stubbed(:like)
  end

  subject { @like }

  it { should respond_to(:user) }
  it { should respond_to(:publication) }

  it { should be_valid }

  describe "when user is empty it" do
    before { @like.user = nil }
    it { should_not be_valid }
  end

  describe "when publication is empty it" do
    before { @like.publication = nil }
    it { should_not be_valid }
  end
end
