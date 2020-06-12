class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :created_event
      t.references :attendee

      t.timestamps
    end
  end
end
