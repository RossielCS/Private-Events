class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.text :description
      t.string :location
      t.date :date

      t.timestamps
    end
  end
end
