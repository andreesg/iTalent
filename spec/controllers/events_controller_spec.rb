require 'spec_helper'

describe EventsController do
	before :all do
		@user = create(:user)
	end

	after :all do
		@user.destroy
	end

	describe "GET #index" do
		describe "when authenticated" do
			before :each do
				@tag = create(:tag)
				@events = create_list(:event,5,:tags => [@tag])
				sign_in @user
			end

			describe "when valid tags are passed" do
				it "assigns the requested events (with those tags) to @events" do
					get :index, :tags_ids => [@tag.id]
					assigns(:events).should eq(@events)
				end
			end

			describe "when invalid tags are passed" do
				it "@events should be empty" do
					get :index, :tags_ids => [@tag.id+100]
					assigns(:events).should eq([])
				end
			end

			describe "when no argument is passed" do
				it "assigns @events with all events" do
					get :index
					assigns(:events).should eq(Event.all)
				end
			end
		end

		describe "when not authenticated" do
			it "it wont allow the operation" do
				get :index
				response.should redirect_to new_user_session_path
			end
		end
	end

	describe "GET #show" do
		before :each do
			@event = create(:event)
		end

		describe "when authenticated" do
			before :each do
				sign_in @user
			end

			it "assigns the requested Event to @event" do
				get :show, id: @event
				assigns(:event).should eq @event
			end

			it "renders the :show template" do
				get :show, id: @event
				response.should render_template :show
			end
		end

		describe "when not authenticated" do
			it "it wont allow the operation" do
				get :show, id: @event
				response.should redirect_to new_user_session_path
			end
		end
	end

	describe "GET #new" do
		describe "when authenticated" do
			before :each do
				sign_in @user
			end

			it "assigns a new Event to @event" do
				get :new
				assigns(:event).should_not be_nil
			end

			it "renders the :new template" do
				get :new
				response.should render_template :new
			end
		end

		describe "when not authenticated" do
			it "it wont allow the operation" do
				get :new
				response.should redirect_to new_user_session_path
			end
		end
	end

	describe "POST #create" do
		describe "when authenticated" do
			before :each do
				sign_in @user
			end

			context "with valid attributes" do
				it "saves the new event in the database" do
					expect{
						post :create, event: attributes_for(:event)
					}.to change(Event, :count).by(1)
				end

				it "redirects to the timeline" do
					post :create, event: attributes_for(:event)
					response.should redirect_to timeline_index_path
				end
			end

			context "with invalid attributes" do
				it "does not save the new event in the database" do
					expect{
						post :create, event: attributes_for(:invalid_event)
					}.to_not change(Event, :count)
				end

				it "re-renders the timeline index template" do
					post :create, event: attributes_for(:invalid_event)
					response.should render_template 'timeline/index'
				end
			end
		end

		describe "when not authenticated" do
			it "it wont allow the operation" do
				post :create, event: attributes_for(:event)
				response.should redirect_to new_user_session_path
			end
		end
	end

	describe "GET #edit" do
		before :each do
			@event = create(:event, creator: @user)
		end

		describe "when authenticated" do
			before :each do
				sign_in @user
			end

			it "assigns the requested event to @event" do
				get :edit, id: @event
				assigns(:event).should eq(@event)
			end

			it "renders the :edit template" do
				get :edit, id: @event
				response.should render_template :edit
			end

			describe "when the event does not bellong to the user" do
				it "it wont allow the operation" do
					get :edit, id: create(:event)
					response.status.should be(403)
				end
			end
		end

		describe "when not authenticated" do
			it "it wont allow the operation" do
				get :edit, id: @event
				response.should redirect_to new_user_session_path
			end
		end
	end

	describe "PUT #update" do
		before :each do
			@event = create(:event, title: "HEHEHEHE",description: "HEHEHEHE", creator: @user)
		end

		describe "when authenticated" do
			before :each do
				sign_in @user
			end

			context "with valid attributes" do
				it "locates the requested event" do
					put :update, id: @event, event: attributes_for(:event)
					assigns(:event).should eq @event
				end

				it "changes event attributes" do
					put :update, id: @event, 
						event: attributes_for(:event, title: "Something",description: "Something")
					@event.reload
					@event.title.should eq "Something"
				end

				it "redirects to the updated event" do
					put :update, id: @event, event: attributes_for(:event)
					response.should redirect_to @event
				end
			end

			context "with invalid attributes" do
				it "does not change the event attributes" do
					put :update, id: @event, 
						event: attributes_for(:event, text: nil, description: nil)
					@event.reload
					@event.title.should_not eq(nil)
					@event.description.should_not eq(nil)
				end

				it "re-renders the :edit template" do
					put :update, id: @event, event: attributes_for(:invalid_event)
					response.should render_template :edit
				end
			end

			describe "when the event does not bellong to the user" do
				it "it wont allow the operation" do
					put :update, id: create(:event), event: attributes_for(:event)
					response.status.should be(403)
				end
			end
		end

		describe "when not authenticated" do
			it "it wont allow the operation" do
				put :update, id: @event, event: attributes_for(:event)
				response.should redirect_to new_user_session_path
			end
		end
	end

	describe "DELETE #destroy" do
		before :each do
			@event = create(:event, creator: @user)
		end

		describe "when authenticated" do
			before :each do
				sign_in @user
			end

			it "deletes the requested event" do
				expect{
					delete :destroy, id: @event
				}.to change(Event, :count).by(-1)
			end

			it "redirects to the '/' page" do
				delete :destroy, id: @event
				response.should redirect_to '/'
			end

			describe "when the event does not bellong to the user" do
				it "it wont allow the operation" do
					delete :destroy, id: create(:event)
					response.status.should be(403)
				end
			end			
		end

		describe "when not authenticated" do
			it "it wont allow the operation" do
				delete :destroy, id: @event
				response.should redirect_to new_user_session_path
			end
		end
	end

end
