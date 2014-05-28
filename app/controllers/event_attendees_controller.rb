class EventAttendeesController < ApplicationController

	before_filter :authenticate_user!

	def create
		if params[:event_id].nil?
			redirect_to authenticated_root_path
			return
		end
		@event = Event.find(params[:event_id])
		if @event.accepting_attendees?
			current_user.attend(@event)
			respond_to do |format|
				format.html { redirect_to authenticated_root_path, notice: 'Marked as attending' }
				format.js   {}
			end
		else
			redirect_to authenticated_root_path, notice: 'The event is not accepting registrations!' }
		end
	end

	def destroy
		if params[:id].nil?
			redirect_to authenticated_root_path
			return
		end
		@event_attendee = EventAttendee.find(params[:id])	
		respond_to do |format|
			if not @event_attendee.nil? && @event_attendee.attendee == current_user && @event.accepting_attendees?
				@event_attendee.destroy
				@event=@event_attendee.event
				format.html { redirect_to authenticated_root_path, notice: 'Marked as not attending' }
				format.js   {}
			else
				redirect_to authenticated_root_path				
			end
		end
	end

end
