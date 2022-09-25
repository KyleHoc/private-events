class RemoveCreatorIdFromRegistrations < ActiveRecord::Migration[7.0]
  def change
    remove_column :registrations, :creator_id, :integer
  end
end
