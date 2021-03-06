class Event < ActiveRecord::Base

  self.per_page = 10

	has_many :event_attendees, dependent: :destroy, foreign_key: "event_id"
	has_many :attendees, through: :event_attendees, source: :attendee

	before_validation :default_values
  after_create :update_event_stats
	
	has_and_belongs_to_many :tags
	belongs_to :creator, foreign_key: "creator_id", class_name: "User"

  belongs_to :organization

	validates :title,presence:true, length: { maximum:100 }
	validates :num_attendings,presence:true, numericality:{ only_integer:true, greater_than_or_equal_to:0 }
	validates :num_invitations,presence:true, numericality:{ only_integer:true, greater_than_or_equal_to:0 }
	validates :max_attendees, presence:true, numericality:{ only_integer:true, greater_than_or_equal_to:0 }
	validates :description,presence:true, length: { maximum:255 }
	validates :date_limit, presence:true
	validates :date_start, presence:true
	validate :date_end_after_date_start
	validate :date_limit_before_date_start
	validates :tags, presence: true
	validates :creator, presence: true
  validate :max_attendees_cannot_be_less_than_num_attendings, on: :update

	has_many :event_invitations, dependent: :destroy, foreign_key: "event_id"
	has_many :invitees, through: :event_invitations, source: :invitee

	def invite(user)
		self.event_invitations.create(invitee: user)
	end

  def invited?(user)
    self.event_invitations.find_by(invitee: user)
  end

  def accepting_attendees?
    return true if self.date_limit >= Time.now
    return false
  end

  def has_already_occurred?
    if self.date_end.blank?
      end_date = self.date_start
    else
      end_date = self.date_end
    end
    return true if end_date < Time.now
    return false
  end

private
  def max_attendees_cannot_be_less_than_num_attendings
    num_people_attending = attendees.count
    if max_attendees != 0 and max_attendees < num_people_attending
      errors.add(:max_attendees, "can't be set to less than #{num_people_attending}, since there is already people attending the event!")
    end
  end

  def default_values
    self.num_attendings = 0 if self.num_attendings.nil?
    self.num_invitations = 0 if self.num_invitations.nil?
    self.max_attendees = 0 if self.max_attendees.nil?
  end

  def update_event_stats
    creator.user_statistic.change_events_created_by(1)
    creator.user_statistic.save!
  end

  def date_end_after_date_start
    return if date_end.blank? || date_start.blank? || date_limit.blank?
   
    if date_end < date_start
      errors.add(:date_end, "must be after the start date") 
    end 
  end

  def date_limit_before_date_start
    return if date_end.blank? || date_start.blank? || date_limit.blank?
   
    if date_limit > date_start
      errors.add(:date_limit, "must be before the start date") 
    end 
  end

  def initialize(attributes = {})
    super
    self.max_attendees ||= 0
  end
end
