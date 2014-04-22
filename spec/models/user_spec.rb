require 'spec_helper'

describe User do

	before do
		@user = create(:user)
	end

	subject { @user }

	it { should respond_to(:email) }
	it { should respond_to(:created_publications) }
	it { should respond_to(:created_events) }
	it { should respond_to(:subscriptions) }
	it { should respond_to(:subscribed_tags) }
	it { should respond_to(:event_attendees) }
	it { should respond_to(:attending_events) }
	
	it { should be_valid }

	describe "when email is empty" do
		before { @user.email = "" }
		it { should_not be_valid }
	end

	describe "when email is nil" do
		before { @user.email = nil }
		it { should_not be_valid }
	end
	describe "subscribing tag" do
		let(:tag) { create(:tag) }
		let(:invalid_tag) { build_stubbed(:invalid_tag) }
		
		before do 
			@user.subscribe(tag)
		end
		it { should be_subscribing(tag) }

		describe "already subscribed" do
			it "should not create a new subscription" do
				expect { @user.subscribe(tag) }.to raise_error(ActiveRecord::RecordNotUnique)
			end
		end

		describe "that is invalid" do
			it "should not create a new subscription" do
				expect { @user.subscribe(invalid_tag) }.not_to change(Subscription,:count)
			end
		end

		describe "should be possible by multiple users" do
			let(:other_user) {create(:user) }
			it "with the same tag" do
				expect { other_user.subscribe(tag) }.to change(Subscription,:count).by(1) && change(other_user.subscribed_tags,:count).by(1) 
			end

		end
	end

	describe "destroying user" do
		it "should destroy his subscriptions" do
			expect { @user.destroy }.to change(Subscription,:count).by(@user.subscriptions.count)
		end
	end
end