require 'spec_helper'

describe Tag do
	before do
		@tag = build_stubbed(:tag)
	end

	subject { @tag }

	it { should respond_to(:name) }
	it { should respond_to(:num_subscribers)}

	it { should be_valid }

	describe "when name is empty" do
		before { @tag.name = "" }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @tag.name = "A"*31 }
		it { should_not be_valid }
	end

	describe "num_subscribers should never be negative" do
		before { @tag.num_subscribers = -1 }
		it { should_not be_valid }
	end
end
