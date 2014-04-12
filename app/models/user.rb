class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable

	has_many :publications

	has_many :subscriptions, dependent: :destroy
	has_many :subscribed_tags, through: :subscriptions, source: :subscribed_tag

	def subscribe(tag)
		subscriptions.create(tag_id: tag.id)
	end

	def subscribing?(tag)
		subscriptions.find_by(tag_id: tag.id)
	end

	def unsubscribe(tag)
		subscriptions.find_by_tag_id(tag).destroy
	end

end
