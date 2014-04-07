class Tag < ActiveRecord::Base

	has_and_belongs_to_many :publications

	validates :name, presence: true, length: { maximum: 30 }
	validates :num_subscribers, presence: true
	validates_numericality_of :num_subscribers, greater_than_or_equal_to: 0
end
