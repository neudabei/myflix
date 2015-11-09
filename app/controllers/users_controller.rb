class UsersController < ApplicationController
  before_filter :require_user, only: [:show]

  def new
    redirect_to home_path if current_user
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.valid?

      handle_payment_with_stripe
      if @charge.successful?
        @user.save
        handle_invitation
        AppMailer.delay.send_welcome_email(@user)
        flash[:success] = "Thank you for registering with MyFlix. Please sign in now."
        redirect_to login_path
      else
        flash.now[:error] = @charge.error_message
        render :new
      end
    else
      flash.now[:error] = "Invalid user information. Please check the errors below."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new_with_invitation_token
    invitation = Invitation.find_by(token: params[:token])

    if invitation
      @user = User.new(email: invitation.recipient_email)
      @invitation_token = invitation.token
      render :new
    else
      redirect_to expired_token_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end

  def handle_invitation
    if params[:invitation_token].present?
      invitation = Invitation.find_by(token: params[:invitation_token])
      @user.follow(invitation.inviter)
      invitation.inviter.follow(@user)
      invitation.update_column(:token, nil)
    end
  end

  def handle_payment_with_stripe
    token = params[:stripeToken]
    @charge = StripeWrapper::Charge.create(
      amount: 999, 
      source: token, 
      description: "Sign up charge for #{@user.email}"
      )
  end
end