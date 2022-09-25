class RenameEventIdToAttendedEventId < ActiveRecord::Migration[7.0]
  def change
    rename_column :registrations, :event_id, :attended_event_id
  end
end
