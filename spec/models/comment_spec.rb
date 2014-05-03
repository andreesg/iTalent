require 'spec_helper'

describe Comment do
	before do
		@comment = create(:comment)
	end

	subject { @comment }

	it { should respond_to(:text) }
	it { should respond_to(:creator) }
	it { should respond_to(:publication) }
	
	it { should be_valid }

	describe "when text is empty it" do
		before { @comment.text = "" }
		it { should_not be_valid }
	end

	describe "when text is too long it" do
		before { @comment.text = 'a' * 501 }
		it { should_not be_valid }
	end

	describe "when creator is not assigned it" do
		before { @comment.creator = nil }
		it { should_not be_valid }
	end

	describe "when publication is not assigned it" do
		before { @comment.publication = nil }
		it { should_not be_valid }
	end
end
