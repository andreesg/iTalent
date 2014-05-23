class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

	has_many :created_publications, class_name: "Publication", foreign_key: "creator_id",
                                  dependent: :destroy
	has_many :created_events, class_name: "Event", foreign_key: "creator_id",
                            dependent: :destroy
	has_many :created_comments, dependent: :destroy

  has_many :subscriptions, dependent: :destroy
  has_many :subscribed_tags, through: :subscriptions, source: :subscribed_tag

  has_many :event_invitations, dependent: :destroy, foreign_key: "invitee_id"
  has_many :events_invited, through: :event_invitation, source: :event

  has_many :event_attendees, dependent: :destroy, foreign_key: "attendee_id"
  has_many :attending_events, through: :event_attendee, source: :event

  has_one :user_statistic,:dependent => :destroy
  before_create :build_default_user_statistic

  has_many :likes, dependent: :destroy
  has_many :liked_publications, through: :like, source: :publication

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
    if event.max_attendees.nil? || event.max_attendees == 0 || event.num_attendings < event.max_attendees
      update_attendee_stats() unless attending?(event)
      event_attendees.find_or_create_by(event: event)
    end
  end

  def attending?(event)
    event_attendees.find_by(event: event)
  end

private

  def build_default_user_statistic
    build_user_statistic
    user_statistic.valid?
  end

  def update_attendee_stats
    user_statistic.change_events_attended_by(1)
    user_statistic.save!
  end

end
