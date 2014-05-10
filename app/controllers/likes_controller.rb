class LikesController < ApplicationController
  before_filter :authenticate_user!

  def create
    success = false
    
    @publication = Publication.find(params[:publication_id])

    # verify first if the user has already liked the publication, lets try to see what error it returns!
    if @publication.likes.find_by(user: current_user).nil?
      @like = @publication.likes.new() # like as no params.
      @like.user = current_user
      success = true if @like.save!
    else
      success = true # the like was already made! proced successfuly
    end

    respond_to do |format|
      if success
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
    @like = @publication.likes.find_by(user: current_user)

    @like.destroy unless @like.nil?

    respond_to do |format|
      format.html { redirect_to timeline_index_path, notice: 'The publication was successfully unliked!' }
      format.js   {}
    end
  end
end
