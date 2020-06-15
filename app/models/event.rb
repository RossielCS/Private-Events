class Event < ApplicationRecord
  validates :description, length: { in: 10..120 }
  validates :location, length: { in: 5..50 }

  belongs_to :creator, class_name: 'User'
  has_many :invitations, dependent: :destroy

  scope :upcoming, -> { where('date >= ?', DateTime.now.to_date) }
  scope :past, -> { where('date < ?', DateTime.now.to_date) }

  def event_attendees
    users = []
    invitations.each do |i|
      users << User.find_by_id(i.user_id)
    end
    users
  end
end
