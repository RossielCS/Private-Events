class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :user
      t.references :event

      t.timestamps
    end
  end
end
