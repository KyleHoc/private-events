class FixStringColumns2 < ActiveRecord::Migration[7.0]
  def change
    change_column :registrations, :attendee_id, :integer
  end
end
