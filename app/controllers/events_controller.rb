class EventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @events = nil
    unless params[:tags_ids].nil?
      @events=Event.includes(:tags).where({'tags.id' => params[:tags_ids]})
    else
      @events=Event.all
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @new_event = Event.new(event_params)
    @new_event.tags = Tag.find(params[:event][:tags]) unless params[:event][:tags].nil?
    @new_event.creator = current_user

    if @new_event.save
      redirect_to timeline_index_path
    else
      @publications=Publication.paginate(page: params[:publications_page],per_page: 100).order('created_at DESC')
      @events=Event.paginate(page: params[:events_page],per_page: 100).order('date_start DESC')
      @new_publication = Publication.new  
      render '/timeline/index'
    end
  end

  def edit
    @event = Event.find(params[:id])
    return head :forbidden unless @event.creator.id == current_user.id
  end

  def update
    @event = Event.find(params[:id])
    return head :forbidden unless @event.creator.id == current_user.id
    if @event.update_attributes(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    return head :forbidden unless @event.creator.id == current_user.id
    @event.destroy
    redirect_to authenticated_root_path
  end
  
  private 
  
  def event_params
    params.require(:event).permit(:title,:description,:date_start,:date_limit,:tags)
  end
end
