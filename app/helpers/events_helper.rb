module EventsHelper
  def verify_attendees
    users = User.select{ |x| x.id != current_user.id }
    users
  end

  def create_invitation(attendees, event_id)
    attendees.each do |attendee|
      Invitation.create(event_id: event_id, user_id: attendee)
    end
  end
end
