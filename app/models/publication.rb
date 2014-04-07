class Publication < ActiveRecord::Base

	has_and_belongs_to_many :tags
	
	validates :text, presence: true, length: { maximum: 150 }
	validates :tags, presence: true
end
