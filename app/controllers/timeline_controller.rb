class TimelineController < ApplicationController

  before_filter :authenticate_user!

  def index
    @publications = Publication.includes(:creator).paginate(page: params[:publications_page],per_page:10).order('created_at DESC')
    @publications.each do |p|
      p.paginated_comments = p.comments.includes(:creator).paginate(page: 1, per_page: 10).order('updated_at ASC')
    end

    @events = Event.includes(:creator).paginate(page: params[:events_page],per_page:10).order('date_start DESC')
    @new_publication = Publication.new
    @new_event = Event.new
    @comment = Comment.new

    @all_publications = Publication.all
    gon.rabl "app/views/timeline/index.json.rabl", as: 'publications'
    
  end

end
