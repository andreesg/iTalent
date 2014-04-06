class Publication < ActiveRecord::Base

	belongs_to :creator, foreign_key: "creator_id", class_name: "User"

	validates :text, presence: true, length: { maximum: 150 }
	#validates :creator, presence: true

end
