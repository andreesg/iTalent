class UserStatistic < ActiveRecord::Base

	def change_events_created_by(number)
	  self.number_events_created+=number
	end
	def change_events_attended_by(number)
		self.number_events_attended+=number
	end
	def change_publications_created_by(number)
		self.number_publications_created+=number
	end
end
