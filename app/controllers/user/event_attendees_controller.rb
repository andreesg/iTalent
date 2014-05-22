class User::EventAttendeesController < ApplicationController

	before_filter :authenticate_user!

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