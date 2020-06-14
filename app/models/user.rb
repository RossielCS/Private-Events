class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :username, length: { in: 4..20 },
                       uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, length: { maximum: 50 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }

  has_many :created_events, foreign_key: 'creator_id', class_name: 'Event'
  has_many :invitations

  def upcoming_events
    result = []
    invitations.each do |e|
      result << e.event if e.event.date >= DateTime.now.to_date
    end
    result
  end

  def previous_events
    result = []
    invitations.each do |e|
      result << e.event if e.event.date < DateTime.now.to_date
    end
    result
  end
end
