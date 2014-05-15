class Event < ActiveRecord::Base

	has_many :event_attendees, dependent: :destroy, foreign_key: "event_id"
	has_many :attendees, through: :event_attendee, source: :attendee

	before_validation :default_values
	
	has_and_belongs_to_many :tags
	belongs_to :creator, foreign_key: "creator_id", class_name: "User"

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



	has_many :event_invitations, dependent: :destroy, foreign_key: "event_id"
	has_many :invitees, through: :event_invitation, source: :invitee

	def invite(user)
		self.event_invitations.create(invitee: user)
	end

	def invited?(user)
		self.event_invitations.find_by(invitee: user)
	end

	private
		def default_values
			self.num_attendings = 0 if self.num_attendings.nil?
			self.num_invitations = 0 if self.num_invitations.nil?
			self.max_attendees = 0 if self.max_attendees.nil?
		end


	def date_end_after_date_start
    return if date_end.blank? || date_start.blank?
   
    if date_end < date_start
      errors.add(:date_end, "must be after the start date") 
    end 
  end

  def date_limit_before_date_start
    return if date_end.blank? || date_start.blank?
   
    if date_limit > date_start
      errors.add(:date_end, "must be after the start date") 
    end 
  end
end
