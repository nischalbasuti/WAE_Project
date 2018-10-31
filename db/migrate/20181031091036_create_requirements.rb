class CreateRequirements < ActiveRecord::Migration[5.2]
  def change
    create_table :requirements do |t|
      t.string :title
      t.text :description
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
