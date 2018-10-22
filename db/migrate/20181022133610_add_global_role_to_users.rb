class AddGlobalRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :global_role, :string
  end
end
