require 'spec_helper'

describe PublicationsController do

  describe "GET #index" do
    before :each do
      create(:publication)
      @tag = create(:tag)
      @publications = create_list(:publication, 5, :tags => [@tag])
    end

    describe "when valid tag ids are passed" do
      it "assigns the resquested Publications to @publications" do
        get :index, :tags_ids => [@tag.id]
        assigns(:publications).should eq(@publications)
      end
    end

    describe "when invalid tag ids are passed" do
      it "assigns the resquested Publications to @publications" do
        get :index, :tags_ids => [@tag.id+10]
        assigns(:publications).should eq([])
      end
    end

    describe "when no argument is passed" do
      it "assigns the resquested Publications to @publications" do
        get :index
        assigns(:publications).should eq(Publication.all)
      end
    end

  end

  describe "GET #show" do
    it "assigns the requested Publication to @publication" do
      publication = create(:publication)
      get :show, id: publication
      assigns(:publication).should eq(publication)
    end

    it "renders the :show template" do
      get :show, id: create(:publication)
      response.should render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a new Publication to @publication" do
      get :new
      assigns(:publication).should_not be_nil
    end

    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new publication in the database" do
        expect{
          post :create, publication: attributes_for(:publication)
        }.to change(Publication, :count).by(1)
      end

      it "redirects to the new publication" do
        post :create, publication: attributes_for(:publication)
        response.should redirect_to Publication.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new publication in the database" do
        expect{
          post :create, publication: attributes_for(:invalid_publication)
        }.to_not change(Publication, :count)
      end

      it "re-renders the :new template" do
        post :create, publication: attributes_for(:invalid_publication)
        response.should render_template :new
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested publication to @publication" do
      publication = create(:publication)
      get :edit, id: publication
      assigns(:publication).should eq(publication)
    end

    it "renders the :edit template" do
      get :edit, id: create(:publication)
      response.should render_template :edit
    end
  end

  describe "PUT #update" do
    before :each do
      @publication = create(:publication, text: "HEHEHEHE")
    end

    context "with valid attributes" do
      it "locates the requested publication" do
        put :update, id: @publication, publication: attributes_for(:publication)
        assigns(:publication).should eq(@publication)
      end

      it "changes publication attributes" do
        put :update, id: @publication, 
          publication: attributes_for(:publication, text: "Something")
        @publication.reload
        @publication.text.should eq("Something")
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
  end

  describe "DELETE #destroy" do
    before :each do
      @publication = create(:publication)
    end

    it "deletes the requested publication" do
      expect{
        delete :destroy, id: @publication
      }.to change(Publication, :count).by(-1)
    end

    it "redirects to the '/' page" do
      delete :destroy, id: @publication
      response.should redirect_to '/'
    end
  end

end
