class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

	has_many :created_publications, class_name: "Publication", foreign_key: "creator_id"
	has_many :created_events, class_name: "Event", foreign_key: "creator_id"
	has_many :created_comments, class_name: "Comment", foreign_key: "creator_id"

  has_many :subscriptions, dependent: :destroy
  has_many :subscribed_tags, through: :subscriptions, source: :subscribed_tag

  has_many :event_invitations, dependent: :destroy, foreign_key: "invitee_id"
  has_many :events_invited, through: :event_invitations, source: :event

  has_many :event_attendees, dependent: :destroy, foreign_key: "attendee_id"
  has_many :attending_events, through: :event_attendees, source: :event

  has_many :likes, dependent: :destroy
  has_many :liked_publications, through: :like, source: :publication

  has_many :access_logs

  belongs_to :organization


  before_create :ensure_name


  validates :role, inclusion: { in: %w(basic admin),
    message: "%{value} is not a role" }
  
  def role?(r)
    role.include? r.to_s
  end

  def ensure_name
    self.name = email.split("@")[0]
  end

  def subscribe(tag)
    subscriptions.create(tag_id: tag.id)
  end

  def subscribing?(tag)
    subscriptions.find_by(tag_id: tag.id)
  end

  def unsubscribe(tag)
    subscriptions.find_by_tag_id(tag).destroy
  end

  def attend(event)
    if event.max_attendees==0 || event.num_attendings < event.max_attendees
      event_attendees.find_or_create_by(event: event)
    end
  end

  def attending?(event)
    event_attendees.find_by(event: event)
  end

end
