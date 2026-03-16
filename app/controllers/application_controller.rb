class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(resource)
    if resource.staff? || resource.admin?
      admin_root_path
    else
      root_path
    end
  end

  private
  def require_staff!
    redirect_to root_path, alert: 'You are not authorized to access this page.' unless current_user.staff?
  end

  def require_admin!
    redirect_to root_path, alert: 'You are not authorized to access this page.' unless current_user.admin?
  end

  def require_user_role!
    redirect_to admin_root_path, alert: 'You are not authorized to access this page.' unless current_user.user?
  end
end
