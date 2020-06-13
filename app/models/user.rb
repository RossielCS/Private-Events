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

  has_many :created_events, foreign_key: 'creator_id', class_name: 'Event'
  has_many :invitations, foreign_key: 'attendee_id'
  has_many :attended_events, through: :invitations, source: :created_event

  def upcoming_events
    result = []
    attended_events.each do |e|
      result << e if e.date >= DateTime.now.to_date
    end
    result
  end

  def previous_events
    result = []
    attended_events.each do |e|
      result << e if e.date < DateTime.now.to_date
    end
    result
  end
end
