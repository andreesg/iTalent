class User::EventAttendeesController < ApplicationController

	before_filter :authenticate_user!

	def destroy
		unless params[:id].nil?
			@event_attendee = EventAttendee.find(params[:id])
			@event_attendee.destroy unless @event_attendee.nil? or @event_attendee.attendee != current_user
		end
	end

end
