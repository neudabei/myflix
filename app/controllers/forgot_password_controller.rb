class ForgotPasswordController < ApplicationController
  def new
  end

  def create
    user = User.where(email: params[:email]).first
    if user
      user.generate_token
      user.save
      AppMailer.send_forgot_password(user).deliver
      redirect_to forgot_password_confirmation_path
    else
      flash[:error] = params[:email].blank? ? "Email cannot be blank." : "There is no user this email address in the system."
      redirect_to forgot_password_path
    end
  end
end