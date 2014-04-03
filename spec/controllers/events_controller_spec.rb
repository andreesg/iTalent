require 'spec_helper'

describe EventsController do
 describe "GET #show" do
    it "assigns the requested Event to @event" do
      event = create(:event)
      get :show, id: event
      assigns(:event).should eq event
    end

    it "renders the :show template" do
      get :show, id: create(:event)
      response.should render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a new Event to @event" do
      get :new
      assigns(:event).should_not be_nil
    end

    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new event in the database" do
        expect{
          post :create, event: attributes_for(:event)
        }.to change(Event, :count).by(1)
      end

      it "redirects to the new event" do
        post :create, event: attributes_for(:event)
        response.should redirect_to Event.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new event in the database" do
        expect{
          post :create, event: FactoryGirl.attributes_for(:invalid_event)
        }.to_not change(Event, :count)
      end

      it "re-renders the :new template" do
        post :create, event: FactoryGirl.attributes_for(:invalid_event)
        response.should render_template :new
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested event to @event" do
      event = create(:event)
      get :edit, id: event
      assigns(:event).should eq(event)
    end

    it "renders the :edit template" do
      get :edit, id: create(:event)
      response.should render_template :edit
    end
  end

  describe "PUT #update" do
    before :each do
      @event = create(:event, title: "HEHEHEHE",description: "HEHEHEHE")
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
        put :update, id: @event, event: FactoryGirl.attributes_for(:invalid_event)
        response.should render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @event = create(:event)
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
  end

end
