class TimelineController < ApplicationController

  before_filter :authenticate_user!

  def index

    @publications = Publication.includes(:creator).paginate(page: params[:page], per_page:5).order('created_at DESC')
    @publications.each do |p|
      p.paginated_comments = p.comments.includes(:creator).paginate(page: 1).order('updated_at DESC')
      p.paginated_comments = p.paginated_comments.reverse
      p.has_a_next_page_of_comments = true
      p.has_a_next_page_of_comments = false if p.comments.includes(:creator).paginate(page: 1).order('updated_at DESC').next_page.nil?
    end

    @events = Event.includes(:creator).where('date_start >= ?', Time.now).paginate(page: params[:events_page]).order('date_start ASC')
    @new_publication = Publication.new
    @new_event = Event.new
    @comment = Comment.new

    respond_to do |format|
      format.html {}
      format.js {}
    end
  end
end
