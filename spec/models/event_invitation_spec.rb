require 'spec_helper'

describe EventInvitation do

	before do
		@event_invitation = build_stubbed(:event_invitation)
	end

	subject { @event_invitation }

	it { should respond_to(:invitee) }
	it { should respond_to(:event) }
	it { should respond_to(:status) }

	it { should be_valid }

	describe "when invitee is null" do
		before { @event_invitation.invitee = nil }
		it { should_not be_valid }
	end

	describe "when event is null" do
		before { @event_invitation.event = nil }
		it { should_not be_valid }
	end

end
