require 'spec_helper'

describe Event do

	before do
        @event = FactoryGirl.build_stubbed(:event)
    end

    subject { @event } 

	it { should respond_to :title }
	it { should respond_to :description }
	it { should respond_to :location }
	it { should respond_to :date_limit }
	it { should respond_to :date_start }
	it { should respond_to :num_attendings }
	it { should respond_to :num_invitations }
	it { should respond_to :created_at }
	it { should respond_to :updated_at }

	it { should be_valid }

	describe "default value for number of invitations and attendings should be zero" do
		its(:num_attendings) { should eq 0 }
		its(:num_invitations) { should eq 0 }
	end
	describe "start date should not be empty" do
		before { @event.date_start = nil }
		it { should_not be_valid }
	end
	describe "attending limit should be before the time of event" do
		before{
			@event.date_limit=DateTime.now+1
			@event.date_start=DateTime.now-1
		}
		it { should_not be_valid }
	end
	describe "title should not be empty" do
		before { @event.title = "" }
        it { should_not be_valid }
	end

	describe "number of attendings must be equal or more than zero" do
		before { @event.num_attendings = -1 }
		it { should_not be_valid}
	end

	describe "number of invitations must be equal or more than zero" do
		before { @event.num_invitations = -1 }
		it { should_not be_valid}
	end
	
	describe "title should be short" do
		before { @event.title = 'a' * 110 }
    	it { should_not be_valid }
	end
	describe "description should be short" do
		before { @event.description = 'a' * 265 }
    	it { should_not be_valid }
	end


end
