require 'spec_helper'

describe TimelineController do


	describe "GET #index" do

		describe "when user is not authenticated" do

			it "redirects to the sign_in page" do
				get :index
				response.should redirect_to new_user_session_path
			end

		end

		describe "when user is authenticated" do
			before :all do
				@user = create(:user)
			end

			after :all do
				@user.destroy
			end


			before :each do
				sign_in @user
				@tag = create(:tag)
				@events=create_list(:event,5,:tags => [@tag])
				@events = Event.order('date_start DESC')
      			@publications = create_list(:publication, 5, :tags => [@tag], creator: @user)
      			@publications = Publication.order('created_at DESC')
			end

			it "assigns the requested Publications to @publications" do
				get :index
				assigns(:publications).should_not be_nil
			end

			it "assigns the requested Events to @events" do
				get :index
				assigns(:events).should_not be_nil
			end

			it "renders the :index template" do
				get :index
				response.should render_template :index
			end

		end

	end

end
