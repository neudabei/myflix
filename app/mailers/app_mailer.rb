class AppMailer < ActionMailer::Base
  def notify_on_someone_following_you(another_user)
    @another_user = another_user
    mail from: "info@myflix.com", to: another_user.email, subject: "#{another_user.full_name} is following you"
  end
end