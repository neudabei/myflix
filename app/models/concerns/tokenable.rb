module Tokenable
  extend ActiveSupport::Concern

  included do
    before_create :set_token_in_invitation_table
  end

  def set_token_in_invitation_table
    self.token = SecureRandom.urlsafe_base64
  end

end