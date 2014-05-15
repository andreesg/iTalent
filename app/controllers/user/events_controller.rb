class User::EventsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html, :js

  def edit
    @event = Event.find(params[:id])
    return head :forbidden unless @event.creator.id == current_user.id
  end

  def update
    @event = Event.find(params[:id])
    return head :forbidden unless @event.creator.id == current_user.id
    
    @event.update_attributes(event_params)
  end
  
  def destroy
    @event = Event.find(params[:id])
    return head :forbidden unless @event.creator.id == current_user.id
    
    @event.destroy
  end
  
  private 
  
  def event_params
    params.require(:event).permit(:title,:description,:date_start,:max_attendees,:date_limit,:tags, :date_end)
  end
end
