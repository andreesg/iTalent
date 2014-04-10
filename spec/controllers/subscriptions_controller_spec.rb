require 'spec_helper'

describe SubscriptionsController do
  before do
      @user = create(:regular_user)
  end
  let(:tag) { create(:tag) }
  
  describe "POST #create" do
    context "with valid attributes" do
      it "saves a new subscription in the database" do
        expect{
          post :create, subscription: { tag_id: tag.id }
        }.to change(Subscription, :count).by(1)
      end
    end
  end
  describe "DELETE #destroy" do
    before do
      @subscription=@user.subscribe(tag)
    end
    it "deletes the requested subscription" do
      expect{
        delete :destroy, id: @subscription
      }.to change(Subscription, :count).by(-1)
    end
  end

end
