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
    @new_publication = Publication.new(publication_params)
    @new_publication.tags = Tag.find(params[:publication][:tags]) unless params[:publication][:tags].nil?
    @new_publication.creator = current_user

    if @new_publication.save
      redirect_to timeline_index_path
    else
      @publications=Publication.paginate(page: params[:publications_page],per_page: 100).order('created_at DESC')
      @events=Event.paginate(page: params[:events_page],per_page: 100).order('date_start DESC')
      @new_event = Event.new  
      render '/timeline/index'
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
    redirect_to :back
  end

  private 

  def publication_params
    params.require(:publication).permit(:text)
  end
end
