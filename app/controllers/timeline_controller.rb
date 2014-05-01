class TimelineController < ApplicationController

	before_filter :authenticate_user!

	def index
		@publications=Publication.paginate(page: params[:publications_page],per_page:100)
		@events=Event.paginate(page: params[:events_page],per_page:100)
	end

end
