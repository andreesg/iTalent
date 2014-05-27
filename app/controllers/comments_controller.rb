class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @publication = Publication.find(params[:publication_id])
    @comment = @publication.comments.new(comment_params)
    @comment.creator = current_user

    respond_to do |format|
      if @comment.save
        notice_msg = 'Comment was successfully created!'
        format.html { redirect_to timeline_index_path, notice: notice_msg }
        format.js   { render "create", locals: { success: true, notice: notice_msg } }
      else
        notice_msg = @comment.errors
        format.html { redirect_to timeline_index_path, notice: notice_msg }
        format.js   { render "create", locals: { success: false, notice: notice_msg } }
      end
    end
  end

  def destroy
    @publication = Publication.find(params[:publication_id])
    @comment = @publication.comments.find(params[:id])

    respond_to do |format|
      if @comment.creator == current_user
        @comment.destroy
        format.html { redirect_to timeline_index_path, notice: 'The comment was deleted successfully!' }
        format.js   {}
      else
        return head :forbidden
      end
    end
  end

  def load
    unless params[:last_comment_id].nil?
      @publication = Publication.find(params[:publication_id])
      comment = @publication.comments.find(params[:last_comment_id])
      puts comment
      @comments = @publication.comments.where("updated_at < ?", comment.updated_at).order("updated_at DESC").limit(10)
      @comments.reverse! # to put the array of comments at "updated_at ASC" order
    end

    print @comments.empty?

    respond_to do |format|
      if @comments.nil?
        format.any { render status: 400 }
      else
        if @comments.empty?
          format.js { render status: 204 }
        else
          format.js { render "load" }
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
