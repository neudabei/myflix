class InvitationsController < AuthenticatedController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params.merge!(inviter_id: current_user.id))
    if @invitation.save    
      AppMailer.delay.send_invitation_email(@invitation)
      flash[:success] = "You have successfully invited #{@invitation.recipient_name}."
      redirect_to new_invitation_path
    else
      flash.now[:error] = "Your invitation could not be sent. Please check your inputs."
      render :new
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:inviter_id, :recipient_name, :recipient_email, :token, :message)
  end
end