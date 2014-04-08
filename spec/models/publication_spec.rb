require 'spec_helper'

describe Publication do
	
	before do
		@publication = build_stubbed(:publication)
	end

	subject { @publication }

	it { should respond_to(:text) }
	it { should respond_to(:tags) }
	it { should respond_to(:creator) }

	it { should be_valid }

	describe "when text is empty it" do
		before { @publication.text = "" }
		it { should_not be_valid }
	end

	describe "when text is too long it" do
		before { @publication.text = 'a' * 151 }
		it { should_not be_valid }
	end

	describe "when it has no tags associated" do
		before { @publication.tags = [] }
		it { should_not be_valid }
	end

	describe "when creator is not assigned it" do
		before { @publication.creator = nil }
		it { should_not be_valid }
	end
end