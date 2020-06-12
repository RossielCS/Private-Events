module EventsHelper
  def create_invitation(attendees, event_id)
    attendees.each do |attendee|
      Invitation.create(created_event_id: event_id, attendee_id: attendee)
    end
  end
end
