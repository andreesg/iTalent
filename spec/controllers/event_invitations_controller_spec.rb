require 'spec_helper'

describe EventInvitationsController do

	before :each do
		@event = create(:event)
		@user = create(:user)
	end

	describe "POST #create" do
		context "with valid attributes" do
			it "saves a new invitation to the database" do
				expect{
					post :create, invitee_id: @user.id, event_id: @event.id
				}.to change(EventInvitation, :count).by(1)
			end
		end

		context "with invalid attributes" do
			it "wont save a new invitation without invitee" do
				expect{
					post :create, event_id: @event.id
				}.to_not change(EventInvitation, :count)
			end
			
			it "wont save a new invitation without event" do
				expect{
					post :create, invitee_id: @user.id
				}.to_not change(EventInvitation, :count)
			end

			it "wont save a new invitation to the database" do
				expect{
					post :create
				}.to_not change(EventInvitation, :count)
			end
			
		end
	end

end
