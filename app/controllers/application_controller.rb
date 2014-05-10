class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # checks if the user has liked the publication
  def liked_publication?(publication_id)
    return false if (publication = Publication.find(publication_id)).nil?
    return false if publication.likes.find_by(user: current_user).nil?
    return true
  end

  # makes the method available for all views
  helper_method :liked_publication?

end
