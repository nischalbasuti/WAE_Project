class AddColumnToUserRoles < ActiveRecord::Migration[5.2]
  def change
    add_column :user_roles, :user_id, :integer
    add_column :user_roles, :role_id, :integer
    add_column :user_roles, :event_id, :integer
  end
end
