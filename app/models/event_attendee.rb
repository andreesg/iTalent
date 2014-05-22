class EventAttendee < ActiveRecord::Base
  belongs_to :attendee, class_name: "User"
  belongs_to :event

  validates :attendee, presence: true
  validates :event, presence: true

  after_create :increment_event_num_attendings

private
  def increment_event_num_attendings
    self.event.num_attendings += 1
    self.event.save!
  end

end
