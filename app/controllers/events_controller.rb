class EventsController < ApplicationController
  def index
    @events = nil
    unless params[:tags_ids].nil?
      @events=Event.includes(:tags).where({'tags.id' => params[:tags_ids]})
    else
      @events=Event.all
    end
  end

  def create
    @event = Event.new(event_params)
    @event.creator = current_user
    @event.tags=Tag.find(params[:event][:tags])
    if @event.save
      redirect_to @event
    else
      render 'new'
    end
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to '/'
  end
  private 
    def event_params
      params.require(:event).permit(:title,:description,:date_start,:date_limit,:tags)
    end
end

