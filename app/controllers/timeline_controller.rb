class TimelineController < ApplicationController

	before_filter :authenticate_user!

	def index
		@publications=Publication.all
		@events=Event.all		
	end

end
