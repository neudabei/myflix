class AdminsController < AuthenticatedController
  before_action :require_admin

  private
  
  def require_admin
    if !current_user.admin?
      flash[:error] = "You are not authorized to perform this action."
      redirect_to home_path 
    end
  end
end