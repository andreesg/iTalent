class Publication < ActiveRecord::Base

	has_and_belongs_to_many :tags
	belongs_to :creator, foreign_key: "creator_id", class_name: "User"

	has_many :likes, dependent: :destroy
	has_many :users_that_liked, through: :likes, source: :user

	validates :text, presence: true, length: { maximum: 150 }
	validates :tags, presence: true
	validates :creator, presence: true

end
