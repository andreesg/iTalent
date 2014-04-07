class PublicationsController < ApplicationController
  def show
    @publication = Publication.find(params[:id])
  end

  def new
    @publication = Publication.new
  end

  def create
    @publication = Publication.new(publication_params)
    tag = Tag.first
    tag = Tag.create(name: "Tag", num_subscribers: 0) if tag.nil?
    @publication.tags = [tag]
    if @publication.save
      redirect_to @publication
    else
      render 'new'
    end
  end

  def edit
    @publication = Publication.find(params[:id])
  end

  def update
    @publication = Publication.find(params[:id])
    if @publication.update_attributes(publication_params)
      redirect_to @publication
    else
      render 'edit'
    end
  end

  def destroy
    @publication = Publication.find(params[:id])
    @publication.destroy unless @publication.nil?
    redirect_to '/'
  end

  private 

  def publication_params
    params.require(:publication).permit(:text)
  end
end
