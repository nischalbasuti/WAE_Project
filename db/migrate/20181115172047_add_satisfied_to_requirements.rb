class AddSatisfiedToRequirements < ActiveRecord::Migration[5.2]
  def change
    add_column :requirements, :satisfied, :boolean 
  end
end
