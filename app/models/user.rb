class User < ApplicationRecord
  has_secure_password

  enum role: { admin: 0, consumer: 1 }

  validates :email, presence: true, db_uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  normalizes :email, with: ->(email) { email.strip.downcase }
end
