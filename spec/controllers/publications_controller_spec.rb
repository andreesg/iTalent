require 'spec_helper'

describe PublicationsController do
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
				@publications = create_list(:publication, 5, :tags => [@tag])
				sign_in @user
			end

			describe "when valid tag ids are passed" do
				it "assigns the requested Publications to @publications" do
					get :index, :tags_ids => [@tag.id]
					assigns(:publications).should eq(@publications)
				end
			end

			describe "when invalid tag ids are passed" do
				it "assigns the requested Publications to @publications" do
					get :index, :tags_ids => [@tag.id+10]
					assigns(:publications).should eq([])
				end
			end

			describe "when no argument is passed" do
				it "assigns the requested Publications to @publications" do
					get :index
					assigns(:publications).should eq(Publication.all)
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
			@publication = create(:publication)
		end

		describe "when authenticated" do
			before :each do
				sign_in @user
			end

			it "assigns the requested Publication to @publication" do
				get :show, id: @publication
				assigns(:publication).should eq @publication
			end

			it "renders the :show template" do
				get :show, id: @publication
				response.should render_template :show
			end
		end

		describe "when not authenticated" do
			it "it wont allow the operation" do
				get :show, id: @publication
				response.should redirect_to new_user_session_path
			end
		end
	end

	describe "GET #new" do
		describe "when authenticated" do
			before :each do
				sign_in @user
			end

			it "assigns a new Publication to @publication" do
				get :new
				assigns(:publication).should_not be_nil
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
				it "saves the new publication in the database" do
					expect{
						post :create, publication: attributes_for(:publication)
					}.to change(Publication, :count).by(1)
				end

				it "redirects to the timeline" do
					post :create, publication: attributes_for(:publication)
					response.should redirect_to timeline_index_path
				end

				it "the signed in user is used as the publication creator" do
					post :create, publication: attributes_for(:publication)
					assigns(:new_publication).creator.should eq @user
				end
			end

			context "with invalid attributes" do
				it "does not save the new publication in the database" do
					expect{
						post :create, publication: attributes_for(:invalid_publication)
					}.to_not change(Publication, :count)
				end

				it "re-renders the timeline index template" do
					post :create, publication: attributes_for(:invalid_publication)
					response.should render_template 'timeline/index'
				end
			end
		end

		describe "when not authenticated" do
			it "it wont allow the operation" do
				post :create, publication: attributes_for(:publication)
				response.should redirect_to new_user_session_path
			end
		end
	end

	describe "GET #edit" do
		before :each do
			@publication = create(:publication, creator: @user)
		end

		describe "when authenticated" do
			before :each do
				sign_in @user
			end

			it "assigns the requested publication to @publication" do
				get :edit, id: @publication
				assigns(:publication).should eq(@publication)
			end

			it "renders the :edit template" do
				get :edit, id: @publication
				response.should render_template :edit
			end

			describe "when the publication does not bellong to the user" do
				it "it wont allow the operation" do
					get :edit, id: create(:publication)
					response.status.should be(403)
				end
			end
		end

		describe "when not authenticated" do
			it "it wont allow the operation" do
				get :edit, id: @publication
				response.should redirect_to new_user_session_path
			end
		end
	end

	describe "PUT #update" do
		before :each do
			@publication = create(:publication, text: "HEHEHEHE", creator: @user)
		end

		describe "when authenticated" do
			before :each do
				sign_in @user
			end

			context "with valid attributes" do
				it "locates the requested publication" do
					put :update, id: @publication, publication: attributes_for(:publication)
					assigns(:publication).should eq @publication
				end

				it "changes publication attributes" do
					put :update, id: @publication, 
						publication: attributes_for(:publication, text: "Something")
					@publication.reload
					@publication.text.should eq "Something"
				end

				it "redirects to the updated publication" do
					put :update, id: @publication, publication: attributes_for(:publication)
					response.should redirect_to @publication
				end
			end

			context "with invalid attributes" do
				it "locates the requested publication" do
					put :update, id: @publication, publication: attributes_for(:publication)
					assigns(:publication).should eq(@publication)
				end

				it "does not change the publication attributes" do
					put :update, id: @publication, 
						publication: attributes_for(:publication, text: nil)
					@publication.reload
					@publication.text.should_not eq(nil)
				end

				it "re-renders the :edit template" do
					put :update, id: @publication, publication: attributes_for(:invalid_publication)
					response.should render_template :edit
				end
			end

			describe "when the publication does not bellong to the user" do
				it "it wont allow the operation" do
					put :update, id: create(:publication), publication: attributes_for(:publication)
					response.status.should be(403)
				end
			end
		end

		describe "when not authenticated" do
			it "it wont allow the operation" do
				put :update, id: @publication, publication: attributes_for(:publication)
				response.should redirect_to new_user_session_path
			end
		end
	end

	describe "DELETE #destroy" do
		before :each do
			@publication = create(:publication, creator: @user)
			#create a single comment for the publication
			create(:comment,publication:@publication,creator: @user)
		end

		describe "when authenticated" do
			before :each do
				sign_in @user
			end

			it "deletes the requested publication" do
				expect{
					delete :destroy, id: @publication
				}.to change(Publication, :count).by(-1)
			end
			
			it "deletes the requested publication and also the comments" do
				expect{
					delete :destroy, id: @publication
				}.to change(Publication, :count).by(-1) && change(Comment,:count).by(-@publication.comments.count)
			end

			it "deletes the requested publication with ajax" do
				expect{
					xhr :delete, :destroy, id: @publication
				}.to change(Publication,:count).by(-1)
			end

			it "redirects to the '/' page" do
				delete :destroy, id: @publication
				response.should redirect_to '/'
			end

			describe "when the publication does not bellong to the user" do
				it "it wont allow the operation" do
					delete :destroy, id: create(:publication)
					response.status.should be(403)
				end
			end
		end

		describe "when not authenticated" do
			it "it wont allow the operation" do
				delete :destroy, id: @publication
				response.should redirect_to new_user_session_path
			end
		end
	end
end
