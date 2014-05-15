class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.num_subscribers = 0
    if @tag.save
      redirect_to @tag
    else
      render 'new'
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update_attributes(tag_params)
      redirect_to @tag
    else
      render 'edit'
    end
  end

  def destroy
    @tag = Tag.find(params[:id]) 
    @tag.destroy unless @tag.nil?
    redirect_to authenticated_root_path
  end

  private 

  def tag_params
    params.require(:tag).permit(:name)
  end

end
