class Invitation < ApplicationRecord
  belongs_to :attended_event, class_name: 'Event'
  belongs_to :attendee, class_name: 'User'
end
