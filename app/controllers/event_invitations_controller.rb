class EventInvitationsController < ApplicationController

	def create
		if params[:invitee_id].nil? or params[:event_id].nil?
			redirect_to '/' # Change this
			return
		end
		@invitee = User.find(params[:invitee_id])
		@event = Event.find(params[:event_id])
		@event.invite(@invitee)
		redirect_to '/'
	end

end
