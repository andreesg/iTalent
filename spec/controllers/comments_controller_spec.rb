require 'spec_helper'

describe CommentsController do

=begin
  before :all do
    @user = create(:user)
  end

  after :all do
    @user.destroy
  end

  describe "GET #index" do
    describe "when authenticated" do
      before :each do
        @publication = create(:publication)
        @comments = create_list(:comment ,5 , publication: @publication)
        sign_in @user
      end

      describe "when a valid publication id is passed" do
        it "assigns the requested comments to @comments" do
          get :index, pulication_id: @publication.id
          assigns(:comments).should eq(@comments)
        end
      end

      describe "when a invalid publication id is passed" do
        it "@comments should be empty" do
          get :index, pulication_id: @publication.id
          assigns(:comments).should eq([])
        end
      end

      describe "when no argument is passed" do
        it "redirects to timeline" do
          get :index
          response.should redirect_to timeline_index_path
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
      @comment = create(:comment)
    end

    describe "when authenticated" do
      before :each do
        sign_in @user
      end

      it "assigns the requested comment to @comment" do
        get :show, id: @comment
        assigns(:comment).should eq @comment
      end

      it "renders the :show template" do
        get :show, id: @comment
        response.should render_template :show
      end
    end

    describe "when not authenticated" do
      it "it wont allow the operation" do
        get :show, id: @comment
        response.should redirect_to new_user_session_path
      end
    end
  end

  describe "GET #new" do
    describe "when authenticated" do
      before :each do
        sign_in @user
      end

      it "assigns a new comment to @comment" do
        get :new
        assigns(:comment).should_not be_nil
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
        it "saves the new comment in the database" do
          expect{
            post :create, comment: attributes_for(:comment)
          }.to change(Comment, :count).by(1)
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

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end
=end
end
