class LikesController < ApplicationController
  before_filter :authenticate_user!

  def create
    # verify first if the user has already liked the publication, lets try to see what error it returns!
    @publication = Publication.find(params[:publication_id])
    @like = @publication.likes.new() # like as no params.
    @like.user = current_user

    respond_to do |format|
      if @like.save!
        format.html { redirect_to timeline_index_path, notice: 'The publication was successfully liked!' }
        format.js {} # change the like button to unlike!
      else
        format.html { redirect_to timeline_index_path, alert: 'An error occured while liking the Publication!' }
        format.js {} # place a error message in the page
      end
    end
  end

  def destroy
    @publication = Publication.find(params[:publication_id])
    @like = @publication.likes.where(user: current_user)

    @like.destroy

    respond_to do |format|
      format.html { redirect_to timeline_index_path, notice: 'The publication was successfully unliked!' }
      format.js   {}
    end
  end
end
