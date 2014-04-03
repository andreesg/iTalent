class Publication < ActiveRecord::Base
	validates :text, presence: true, length: { maximum: 150 }
end
