class SessionsController < ApplicationController

  def new
    redirect_to home_path if current_user
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      user.token = nil
      flash[:notice] = "Welcome, you've logged in."
      redirect_to home_path
    else
      flash[:error] = "There is something wrong with your username and password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out."
    redirect_to root_path
  end

end