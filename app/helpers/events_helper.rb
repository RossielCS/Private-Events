module EventsHelper
  # rubocop:disable Style/InverseMethods
  def verify_attendees
    users = User.select { |x| x.id != current_user.id }
    users
  end
  # rubocop:enable Style/InverseMethods

  def create_invitation(attendees, event_id)
    attendees.each do |attendee|
      Invitation.create(attended_event_id: event_id, attendee_id: attendee)
    end
  end
end
