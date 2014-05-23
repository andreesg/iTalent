class Admin::TagsController < Admin::AdminController

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end
  
  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.create(tag_params)

    if @tag.save
      redirect_to admin_tags_path
    else
      render 'new'
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])

    if @tag.update(tag_params)
      redirect_to admin_tags_path
    else
      render 'new'
    end
  end

  def destroy
    @tag = Tag.destroy(params[:id])

    redirect_to admin_tags_path
  end

  private 

  def tag_params
    params.require(:tag).permit(:name)
  end

end
