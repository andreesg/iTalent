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

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
