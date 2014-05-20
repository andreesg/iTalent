class EventAttendeesController < ApplicationController

	before_filter :authenticate_user!

	def create
		if params[:event_id].nil?
			redirect_to authenticated_root_path
			return
		end
		@event = Event.find(params[:event_id])
		current_user.attend(@event)
		redirect_to authenticated_root_path
	end

	def destroy
		if params[:id].nil?
			redirect_to authenticated_root_path
			return
		end
		@event_attendee = EventAttendee.find(params[:id])
		@event_attendee.destroy unless @event_attendee.nil? or @event_attendee.attendee != current_user
		redirect_to authenticated_root_path
	end

end
