class Event < ApplicationRecord
  validates :description, :location, :date, presence: true
  validates :description, length: { in: 10..120 }
  validates :location, length: { in: 5..50 }

  belongs_to :creator, class_name: 'User'
  has_many :invitations, foreign_key: 'created_event_id'
  has_many :attendees, through: :invitations, source: :attendee
end
