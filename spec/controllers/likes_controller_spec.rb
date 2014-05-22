require 'spec_helper'

describe LikesController do

  before :all do
    @user = create(:user)
  end

  after :all do
    @user.destroy
  end

  describe "POST #create" do
    before :each do
      @publication = create(:publication, creator: @user)
    end

    describe "with format HTML" do
      describe "when authenticated" do
        before :each do
          sign_in @user
        end

        it "saves the like in the database" do
          expect{
            post :create, publication_id: @publication
          }.to change(Like, :count).by(1)
        end

        it "redirects to the timeline" do
          post :create, publication_id: @publication
          response.should redirect_to timeline_index_path
        end

        it "flashes a success message" do
          post :create, publication_id: @publication
          flash[:notice].should eq "The publication was successfully liked!"
        end

        describe "when a double request is made" do
          it "ignores the second request" do
            post :create, publication_id: @publication
            expect{
              post :create, publication_id: @publication
            }.to change(Like, :count).by(0)
          end
        end
      end # describe "when authenticated"

      describe "when not authenticated" do
        it "it wont allow the operation" do
          post :create, publication_id: @publication
          response.should redirect_to new_user_session_path
        end
      end
    end # describe "with format HTML"

    describe "with AJAX" do
      describe "when authenticated" do
        before :each do
          sign_in @user
        end

        it "saves the like in the database" do
          expect{
            xhr :post, :create, publication_id: @publication
          }.to change(Like, :count).by(1)
        end

        it "response should be 200" do
          xhr :post, :create, publication_id: @publication
          response.should be_success
        end

        describe "when a double request is made" do
          it "ignores the second request" do
            xhr :post, :create, publication_id: @publication
            expect{
              xhr :post, :create, publication_id: @publication
            }.to change(Like, :count).by(0)
          end
        end
      end # describe "when authenticated"

      describe "when not authenticated" do
        it "it wont allow the operation" do
          xhr :post, :create, publication_id: @publication
          response.status.should be(401)
        end
      end
    end # describe "with AJAX"
  end # describe "POST #create"

  describe "DELETE #destroy" do
    before :each do
      @publication = create(:publication, creator: @user)
      @like = create(:like, user: @user, publication: @publication)
    end

    describe "with AJAX" do
      describe "when authenticated" do
        before :each do
          sign_in @user
        end

        it "deletes the requested like" do
          expect{
            xhr :delete, :destroy, publication_id: @publication.id
          }.to change(Like, :count).by(-1)
        end

        it "response should be success" do
          xhr :delete, :destroy, publication_id: @publication.id
          response.should be_success
        end
      end # describe "when authenticated"

      describe "when not authenticated" do
        it "it wont allow the operation" do
          xhr :delete, :destroy, publication_id: @publication.id
          response.status.should be(401)
        end
      end
    end # describe "with AJAX"

    describe "format HTML" do
      describe "when authenticated" do
        before :each do
          sign_in @user
        end

        it "deletes the requested like" do
          expect{
            delete :destroy, publication_id: @publication.id
          }.to change(Like, :count).by(-1)
        end

        it "redirects to the timeline page" do
          delete :destroy, publication_id: @publication.id
          response.should redirect_to timeline_index_path
        end

        it "flashes a success message" do
          delete :destroy, publication_id: @publication
          flash[:notice].should eq "The publication was successfully unliked!"
        end
      end # describe "when authenticated"

      describe "when not authenticated" do
        it "it wont allow the operation" do
          delete :destroy, publication_id: @publication.id
          response.should redirect_to new_user_session_path
        end
      end
    end # describe "with format HTML"
  end # describe "DELETE #destroy"

end
