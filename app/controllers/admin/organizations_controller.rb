class Admin::OrganizationsController < Admin::AdminController

  def index
    @organizations = Organization.all
  end
  
  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.create(organization_params)

    if @organization.save
      redirect_to admin_organizations_path
    else
      render 'new'
    end
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])

    if @organization.update(organization_params)
      redirect_to admin_organizations_path
    else
      render 'new'
    end
  end

  private 

  def organization_params
    params.require(:organization).permit(:name)
  end

end
