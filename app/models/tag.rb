class Tag < ActiveRecord::Base

	has_and_belongs_to_many :publications
	has_and_belongs_to_many :events
	has_many :subscriptions
	has_many :subscribers, through: :subscriptions, source: :subscriber

  validates :num_subscribers, presence: true
	validates :name, presence: true, length: { maximum: 30 }
	validates_numericality_of :num_subscribers, greater_than_or_equal_to: 0

  before_validation :ensure_num_subscribers_not_nil


  private

  def ensure_num_subscribers_not_nil
    self.num_subscribers = 0 unless num_subscribers.present?
  end

end
