class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :register_activity

  # checks if the user has liked the publication
  def liked_publication?(publication_id)
    return false if (publication = Publication.find(publication_id)).nil?
    return false if publication.likes.find_by(user: current_user).nil?
    return true
  end

  # makes the method available for all views
  helper_method :liked_publication?

  private

  def register_activity
    unless current_user.nil?
      if current_user.access_logs.present?
        if Time.now - current_user.access_logs.last.created_at > 10.minutes
          current_user.access_logs.create
        end
      else
        current_user.access_logs.create
      end
    end
  end

end
