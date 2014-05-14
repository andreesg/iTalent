class User::PublicationsController < ApplicationController
  before_filter :authenticate_user!

  respond_to :html, :js

  def edit
    @publication = Publication.find(params[:id])
    return head :forbidden unless @publication.creator.id == current_user.id
  end

  def update
    @publication = Publication.find(params[:id])
    @publication.tags = Tag.find(params[:publication][:tags]) unless params[:publication][:tags].nil?

    return head :forbidden unless @publication.creator.id == current_user.id
    @publication.update_attributes(publication_params)
  end

  def destroy
    @publication = Publication.find(params[:id])
    return head :forbidden unless @publication.creator.id == current_user.id
    @publication.destroy unless @publication.nil?
  end

  private 

  def publication_params
    params.require(:publication).permit(:text)
  end
end
