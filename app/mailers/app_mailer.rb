class AppMailer < ActionMailer::Base
  def notify_on_someone_following_you(another_user)
    @another_user = another_user
    mail from: "info@myflix.com", to: another_user.email, subject: "#{another_user.full_name} is following you"
  end

  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: "info@myflix.com", subject: "Welcome to MyFlix!"
  end

  def send_forgot_password(user)
    @user = user
    mail to: user.email, from: "info@myflix.com", subject: "Please reset your password"
  end

  def send_invitation_email(invitation)
    @invitation = invitation
    mail to: invitation.recipient_email, from: "info@myflix.com", subject: "Invitation to join MyFlix!"
  end
end