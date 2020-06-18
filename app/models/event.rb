class Event < ApplicationRecord
  validates :description, length: { in: 10..120 }
  validates :location, length: { in: 5..50 }

  belongs_to :creator, class_name: 'User'
  has_many :invitations, foreign_key: 'attended_event_id'
  has_many :attendees, through: :invitations

  scope :upcoming, -> { where('date >= ?', DateTime.now.to_date) }
  scope :past, -> { where('date < ?', DateTime.now.to_date) }
end
