class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :username, length: { in: 4..20 },
                       uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, length: { maximum: 50 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }

  has_many :events, foreign_key: 'creator_id'
  has_many :invitations, foreign_key: 'attendee_id'
  has_many :attended_events, through: :invitations
end
