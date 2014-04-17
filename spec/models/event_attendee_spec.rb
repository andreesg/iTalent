require 'spec_helper'

describe EventAttendee do

	before do
		@event_attendee = build_stubbed(:event_attendee)
	end

	subject { @event_attendee } 

	it { should respond_to :status }
	it { should respond_to :attendee }
	it { should respond_to :event }

	it { should be_valid }

	describe "when attendee is nil" do
		before { @event_attendee.attendee = nil }
		it { should_not be_valid }
	end

	describe "when event is nil" do
		before { @event_attendee.attendee = nil }
		it { should_not be_valid }
	end

end
