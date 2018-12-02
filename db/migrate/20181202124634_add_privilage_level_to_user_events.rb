class AddPrivilageLevelToUserEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :user_events, :privilage_level, :integer
  end
end
