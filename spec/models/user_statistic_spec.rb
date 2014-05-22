require 'spec_helper'

describe UserStatistic do
	before do
		@stat=create(:user_statistic)
		@user=create(:user)
	end
	subject { @stat }
	it { should respond_to(:number_events_created) }
	it { should respond_to(:number_events_attended) }
	it { should respond_to(:number_publications_created) }

	describe "method " do
		it "change_events_created_by should change its value" do
			expect{@stat.change_events_created_by(1)}.to change{@stat.number_events_created}.from(0).to(1)
		end
		it "change_events_attended_by should should change its value" do
			expect{@stat.change_events_attended_by(1)}.to change{@stat.number_events_attended}.from(0).to(1)
		end
		it "change_publications_created_by should change its value" do
			expect{@stat.change_publications_created_by(1)}.to change{@stat.number_publications_created}.from(0).to(1)
		end
	end

	describe "user_statistic should be updated with user actions" do
		it "should update with new publications" do
			expect{create(:publication,creator: @user)}.to change{@user.user_statistic.number_publications_created}.by(1)
		end
		it "should update when the user says it will attend an event" do
			expect{
				event = create(:event)
				@user.attend(event)
			}.to change{@user.user_statistic.number_events_attended}.by(1)
		end
		it "should update when the user creates an event" do
			expect{
				create(:event,creator:@user)
			}.to change{@user.user_statistic.number_events_created}.by(1)
		end
	end


end
