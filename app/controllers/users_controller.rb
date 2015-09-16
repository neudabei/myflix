class UsersController < ApplicationController
  before_filter :require_user, only: [:show]

  def new
    redirect_to home_path if current_user
    @user = User.new
  end

  def create    
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end

end