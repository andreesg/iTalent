class User::TagsController < ApplicationController

  def edit_multiple
    @tags = current_user.subscribed_tags

    render :edit_multiple
  end

  def update_multiple

    current_user.subscriptions.where.not(tag_id: params[:tag_ids]).delete_all

    if params[:tag_ids]
      params[:tag_ids].each do |tag_id|
        if current_user.subscriptions.where(tag_id: tag_id).empty?

          Subscription.create(user_id: current_user.id, tag_id: tag_id)
        end
      end
    end
  end

  private 

  def tag_params
    params.require(:tag).permit(:name)
  end

end
