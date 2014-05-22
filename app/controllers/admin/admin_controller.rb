class Admin::AdminController < ApplicationController

  before_filter :ensure_admin
  
  private

  def ensure_admin
    redirect_to authenticated_root_path unless current_user.role?(:admin)
  end
end