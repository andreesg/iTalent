class Comment < ActiveRecord::Base

	belongs_to :creator, foreign_key: "creator_id", class_name: "User"
	belongs_to :publication

	validates :text, presence: true, length: { maximum: 500 }
	validates :creator, presence: true

end
