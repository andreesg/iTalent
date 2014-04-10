class SubscriptionsController < ApplicationController
	# TODO remove fake current user
	def create
		@current_user=User.find_by_email("user@italent.com")

		@tag = Tag.find(params[:subscription][:tag_id])
		@current_user.subscribe(@tag)
		render 'show'
	end

	def destroy
		@current_user=User.find_by_email("user@italent.com")

		@tag = @current_user.subscriptions.find_by_id(params[:id]).tag
		@current_user.unsubscribe(@tag)
		render 'show'
	end
end
