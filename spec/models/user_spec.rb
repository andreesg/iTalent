require 'spec_helper'

describe User do

	before do
		@user = build_stubbed(:user)
	end

	subject { @user }

	it { should respond_to(:email) }
	it { should respond_to(:publications) }
	
	it { should be_valid }

	describe "when email is empty" do
		before { @user.email = "" }
		it { should_not be_valid }
	end

	describe "when email is nil" do
		before { @user.email = nil }
		it { should_not be_valid }
	end

end