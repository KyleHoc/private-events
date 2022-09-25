class RenameGuestIdToAttendeeId < ActiveRecord::Migration[7.0]
  def change
    rename_column :registrations, :guest_id, :attendee_id
  end
end
