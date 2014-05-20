class User::EventAttendeesController < ApplicationController

	before_filter :authenticate_user!

	def create
		if params[:event_id].nil?
			redirect_to authenticated_root_path
			return
		end
		@event = Event.find(params[:event_id])
		respond_to do |format|
			current_user.attend(@event)
			format.html { redirect_to authenticated_root_path, notice: 'Marked as attending' }
			format.js   {}
		end
	end

	def destroy
		if params[:id].nil?
			redirect_to authenticated_root_path
			return
		end
		@event_attendee = EventAttendee.find(params[:id])	
		respond_to do |format|
			if not @event_attendee.nil? && @event_attendee.attendee == current_user
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