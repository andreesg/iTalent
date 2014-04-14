require 'spec_helper'

describe TimelineController do

	before :all do
		@user = create(:user)
	end

	after :all do
		@user.destroy
	end

	describe "GET #index" do

		describe "when user is not authenticated" do

			it "redirects to the sign_in page" do
				get :index
				response.should redirect_to new_user_session_path
			end

		end

		describe "when user is authenticated" do

			before :each do
				sign_in @user
			end

			it "assigns the requested Publications to @publications"
			it "assigns the requested Events to @events"

			it "renders the :index template" do
				get :index
				response.should render_template :index
			end

		end

	end

end
