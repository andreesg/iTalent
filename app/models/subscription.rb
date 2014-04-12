class Subscription < ActiveRecord::Base
	belongs_to :subscriber, class_name: 'User', foreign_key: 'user_id'
	belongs_to :subscribed_tag, class_name: 'Tag', foreign_key: 'tag_id'
	
	validates :subscribed_tag, presence: true
	validates :subscriber, presence: true
end
