require 'spec_helper'

describe EventAttendeesController do

	before :each do
		@event = create(:event)
		@user = create(:user)
	end

	describe "POST #create" do
		context "when authenticated" do

			before :each do
				sign_in @user
			end

			context "with valid attributes" do
				it "saves a new event attendee to the database" do
					expect{
						post :create, event_id: @event.id
					}.to change(EventAttendee, :count).by(1)
				end
			end

			context "with invalid attributes" do
				it "wont save a new event attendee without event" do
					expect{
						post :create
					}.to_not change(EventAttendee, :count)
				end
			end
		end

		context "when not authenticated" do
			it "wont allow the operation" do
				expect{
					post :create, event_id: @event.id
				}.to_not change(EventAttendee, :count)
			end
		end
	end

  describe "DELETE #destroy" do

    before do
      @event_attendee = @user.attend(@event)
    end

    context "when authenticated" do

			before :each do
				sign_in @user
			end

	    it "deletes the requested event attending" do
	      expect{
	        delete :destroy, id: @event_attendee
	      }.to change(EventAttendee, :count).by(-1)
	    end
  	end

  	context "when not authenticated" do
  		it "wont allow the operation" do
	      expect{
	        delete :destroy, id: @event_attendee
	      }.to_not change(EventAttendee, :count)
	    end
  	end
  end

end
