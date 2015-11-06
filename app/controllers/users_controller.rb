class UsersController < ApplicationController
  before_filter :require_user, only: [:show]

  def new
    redirect_to home_path if current_user
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      handle_invitation
      handle_payment_with_stripe
      AppMailer.delay.send_welcome_email(@user)
      redirect_to login_path
    else
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
    # Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
    # Stripe::Charge.create(
    #   :amount => 999,
    #   :currency => "gbp",
    #   :source => params[:stripeToken], # obtained with Stripe.js
    #   :description => "Sign up charge for #{@user.email}"
    #   )
    token = params[:stripeToken]
    charge = StripeWrapper::Charge.create(
      amount: 999, 
      source: token, 
      description: "Sign up charge for #{@user.email}"
      )
  end
end