class AddSatisfiedToRequirements < ActiveRecord::Migration[5.2]
  def change
    add_column :requirements, :satisfied, :boolean , default: => false
  end
end
