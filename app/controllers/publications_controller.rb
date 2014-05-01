class PublicationsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @publications = nil
    unless params[:tags_ids].nil?
      @publications = Publication.includes(:tags).where({'tags.id' => params[:tags_ids]})
    else
      @publications = Publication.all
    end
  end

  def show
    @publication = Publication.find(params[:id])
  end

  def new
    @publication = Publication.new
  end

  def create
    @publication = Publication.new(publication_params)
    if params[:publication][:tags].nil?
      @publication.tags = [Tag.first]
    else
      @publication.tags = Tag.find(params[:publication][:tags])
    end
    @publication.creator = current_user
    if @publication.save
      redirect_to @publication
    else
      render 'new'
    end
  end

  def edit
    @publication = Publication.find(params[:id])
    return head :forbidden unless @publication.creator.id == current_user.id
  end

  def update
    @publication = Publication.find(params[:id])
    return head :forbidden unless @publication.creator.id == current_user.id
    if @publication.update_attributes(publication_params)
      redirect_to @publication
    else
      render 'edit'
    end
  end

  def destroy
    @publication = Publication.find(params[:id])
    return head :forbidden unless @publication.creator.id == current_user.id
    @publication.destroy unless @publication.nil?
    redirect_to '/'
  end

  private 

  def publication_params
    params.require(:publication).permit(:text)
  end
end
