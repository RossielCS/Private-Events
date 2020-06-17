class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :attendee
      t.references :attended_event

      t.timestamps
    end
  end
end
