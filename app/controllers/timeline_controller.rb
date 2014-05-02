class TimelineController < ApplicationController

	before_filter :authenticate_user!

	def index
		@publications=Publication.paginate(page: params[:publications_page],per_page:100).order('created_at DESC')
		@events=Event.paginate(page: params[:events_page],per_page:100).order('date_start DESC')
		@new_publication = Publication.new
		@new_event = Event.new
	end

end
