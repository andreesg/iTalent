require 'spec_helper'

describe TagsController do

  describe "GET #show" do
    it "assigns the requested Tag to @tag" do
      tag = create(:tag)
      get :show, id: tag
      assigns(:tag).should eq(tag)
    end

    it "renders the :show template" do
      get :show, id: create(:tag)
      response.should render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a new Tag to @tag" do
      get :new
      assigns(:tag).should_not be_nil
    end

    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new tag in the database" do
        expect{
          post :create, tag: attributes_for(:tag)
        }.to change(Tag, :count).by(1)
      end

      it "redirects to the new tag" do
        post :create, tag: attributes_for(:tag)
        response.should redirect_to Tag.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new tag in the database" do
        expect{
          post :create, tag: attributes_for(:invalid_tag)
        }.to_not change(Tag, :count)
      end

      it "re-renders the :new template" do
        post :create, tag: attributes_for(:invalid_tag)
        response.should render_template :new
      end
    end

    context "with num_subscribers defined" do
      it "saves the new tag with num_subscribers set to zero" do
        post :create, tag: attributes_for(:tag, num_subscribers: 20)
        expect(Tag.last.num_subscribers).to be(0)
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested tag to @tag" do
      tag = create(:tag)
      get :edit, id: tag
      assigns(:tag).should eq(tag)
    end

    it "renders the :edit template" do
      get :edit, id: create(:tag)
      response.should render_template :edit
    end
  end

  describe "PUT #update" do
    before :each do
      @tag = create(:tag, name: "Other tag")
    end

    context "with valid attributes" do
      it "locates the requested tag" do
        put :update, id: @tag, tag: attributes_for(:tag)
        assigns(:tag).should eq(@tag)
      end

      it "changes tag attributes" do
        put :update, id: @tag, 
          tag: attributes_for(:tag, name: "Something")
        @tag.reload
        @tag.name.should eq("Something")
      end

      it "redirects to the updated tag" do
        put :update, id: @tag, tag: attributes_for(:tag)
        response.should redirect_to @tag
      end
    end

    context "with invalid attributes" do
      it "locates the requested tag" do
        put :update, id: @tag, tag: attributes_for(:tag)
        assigns(:tag).should eq(@tag)
      end

      it "does not change the tag attributes" do
        put :update, id: @tag, 
          tag: attributes_for(:tag, name: nil, num_subscribers: 20)
        @tag.reload
        @tag.name.should_not eq(nil)
        @tag.num_subscribers.should eq(0)
      end

      it "re-renders the :edit template" do
        put :update, id: @tag, tag: attributes_for(:invalid_tag)
        response.should render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @tag = create(:tag)
    end

    it "deletes the requested tag" do
      expect{
        delete :destroy, id: @tag
      }.to change(Tag, :count).by(-1)
    end

    it "redirects to the '/' page" do
      delete :destroy, id: @tag
      response.should redirect_to '/'
    end
  end

end
