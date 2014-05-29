class Publication < ActiveRecord::Base

	self.per_page = 5

	# attribute to hold the comments
	# this is a workaround for the pagination problem when loading 
	# the comments for the paginated publications in the timeline
	attr_accessor :paginated_comments, :has_a_next_page_of_comments

	has_and_belongs_to_many :tags
	belongs_to :creator, foreign_key: "creator_id", class_name: "User"
	has_many :comments, dependent: :destroy

	has_many :likes, dependent: :destroy
	has_many :users_that_liked, through: :likes, source: :user

	belongs_to :organization

	validates :text, presence: true, length: { maximum: 150 }
	validates :tags, presence: true
	validates :creator, presence: true
	
	after_create :update_publication_stats
private
	def update_publication_stats
		creator.user_statistic.change_publications_created_by(1)
		creator.user_statistic.save!
	end
end
