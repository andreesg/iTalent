class Event < ActiveRecord::Base
	validates :title,presence:true, length: { maximum:100 }
	validates :num_attendings,presence:true, numericality:{ only_integer:true, greater_than_or_equal_to:0 }
	validates :num_invitations,presence:true, numericality:{ only_integer:true, greater_than_or_equal_to:0 }

	validates :description,presence:true, length: { maximum:255 }
	validates :date_limit, presence:true, date:true
	validates :date_start, presence:true, date:{after_or_equal_to: :date_limit}



end
