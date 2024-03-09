class UserApiKey < ApplicationRecord
  belongs_to :user
  before_create :generate_api_key

  private

  def generate_api_key
    key = SecureRandom.random_bytes(32)
    self.api_key = Base64.strict_encode64(key)
  end
end
