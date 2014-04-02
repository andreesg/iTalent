require 'spec_helper'

describe Publication do
	
	before do
		@publication = FactoryGirl.build_stubbed(:publication)
	end

	subject { @publication }

	it { should respond_to(:text) }

	it { should be_valid }

	describe "when text is empty" do
		before { @publication.text = "" }
		it { should_not be_valid }
	end

	describe "when text is too long" do
		before { @publication.text = 'a' * 151 }
		it { should_not be_valid }
	end
end