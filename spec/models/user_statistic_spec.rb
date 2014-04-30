require 'spec_helper'

describe UserStatistic do
	before do
		@stat=create(:user_statistic)
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
end
