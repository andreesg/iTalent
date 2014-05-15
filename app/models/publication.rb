class Publication < ActiveRecord::Base

	has_and_belongs_to_many :tags
	belongs_to :creator, foreign_key: "creator_id", class_name: "User"

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
