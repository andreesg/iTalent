class EventInvitation < ActiveRecord::Base
  belongs_to :invitee, class_name: "User"
  belongs_to :event

  validates :invitee, presence: true
  validates :event, presence: true
end
