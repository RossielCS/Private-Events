class Invitation < ApplicationRecord
  belongs_to :attendee, class_name: 'User'
  belongs_to :created_event, class_name: 'Event'
end
