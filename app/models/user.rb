class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :username, :email, :password, presence: true
  validates :username, length: { in: 4..20 },
                       uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, length: { maximum: 50 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }

  validates :password, length: { minimum: 6 }
  has_secure_password
end
