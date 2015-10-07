module Tokenable
  extend ActiveSupport::Concern

  included do
    unless self == User
      after_create :update_with_token!
    end
  end

  def update_with_token!
    update_column(:token, generate_token)
  end

  private

  def generate_token
    SecureRandom.urlsafe_base64
  end

end