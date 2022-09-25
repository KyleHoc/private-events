class CreateRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :registrations do |t|
      t.string :creator_id
      t.string :event_id
      t.string :guest_id

      t.timestamps
    end
  end
end
