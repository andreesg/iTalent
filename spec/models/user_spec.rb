require 'spec_helper'

describe User do

  before :each do
    @user = create(:user)
  end

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:created_publications) }
  it { should respond_to(:created_events) }
  it { should respond_to(:subscriptions) }
  it { should respond_to(:subscribed_tags) }
  it { should respond_to(:event_attendees) }
  it { should respond_to(:attending_events) }
  it { should respond_to(:created_comments) }
  
  it { should be_valid }

  describe "when email is empty" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when email is nil" do
    before { @user.email = nil }
    it { should_not be_valid }
  end
  describe "subscribing tag" do
    let(:tag) { create(:tag) }
    let(:invalid_tag) { build_stubbed(:invalid_tag) }
    
    before do 
      @user.subscribe(tag)
    end
    it { should be_subscribing(tag) }

    describe "already subscribed" do
      it "should not create a new subscription" do
        expect { @user.subscribe(tag) }.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end

    describe "that is invalid" do
      it "should not create a new subscription" do
        expect { @user.subscribe(invalid_tag) }.not_to change(Subscription,:count)
      end
    end

    describe "should be possible by multiple users" do
      let(:other_user) {create(:user) }
      it "with the same tag" do
        expect { other_user.subscribe(tag) }.to change(Subscription,:count).by(1) && change(other_user.subscribed_tags,:count).by(1) 
      end

    end
  end

  describe "destroying user" do
    it "should destroy his subscriptions" do
      num_subscriptions = @user.subscriptions.count
      expect { @user.destroy }.to change(Subscription,:count).by(num_subscriptions)
    end
  end

  describe "attending events" do
    let(:event) {create(:event)}
    it "should be allowed" do
        expect { @user.attend(event) }.to change(EventAttendee,:count).by(1) 
    end
    it "attending the same event multiple times should not be allowed" do
      expect { 
        2.times do
          @user.attend(event) 
        end
        }.to_not change(EventAttendee,:count).from(0).to(2) 
    end
    before { event.max_attendees = 1 }
    it "should only allow attending until reaches max_attendees" do
      expect {
        2.times do
          @user.attend(event) 
        end
        }.to change(EventAttendee,:count).from(0).to(event.max_attendees) 
    end
    describe "attending? method" do
      let(:event) {create(:event)}
      before do
        @user.attend(event)
      end
      it "should return true if user already marked as attending" do
        @user.attending?(event).should_not eq nil
      end
    end
  end

  after :each do
    @user.destroy
  end


end