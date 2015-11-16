class SessionsController < ApplicationController

  def new
    redirect_to home_path if current_user
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      if user.active?
        session[:user_id] = user.id
        flash[:notice] = "Welcome, you've logged in."
        redirect_to home_path
      else
        flash[:error] = "Your account has been suspended. Please contact the customer service."
        redirect_to login_path
      end
    else
      flash[:error] = "There is something wrong with your username and password."
      redirect_to login_path # why not render?
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out."
    redirect_to root_path
  end

end