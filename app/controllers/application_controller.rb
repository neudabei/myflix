class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :rate_video

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "Must be logged in to perform this action."
      redirect_to login_path
    end
  end

  def rate_video
    options_for_select([5,4,3,2,1].map {|number| [pluralize(number, "Star")]})
  end

end
