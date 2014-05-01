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
    @event = Event.new(event_params)
    if params[:event][:tags].nil?
      @event.tags = [Tag.first]
    else
      @event.tags = Tag.find(params[:event][:tags])
    end
    @event.creator = current_user
    if @event.save
      redirect_to @event
    else
      render 'new'
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
    redirect_to '/'
  end
  
  private 
  
  def event_params
    params.require(:event).permit(:title,:description,:date_start,:date_limit,:tags)
  end
end
