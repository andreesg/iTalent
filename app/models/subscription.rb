class Subscription < ActiveRecord::Base
	belongs_to :user
	belongs_to :tag
	validates :tag, presence: true
	validates :user, presence: true
end
