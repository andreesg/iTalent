class Like < ActiveRecord::Base
	belongs_to :publication
	belongs_to :user

	validates :publication, presence: true
	validates :user, presence: true
	
end
