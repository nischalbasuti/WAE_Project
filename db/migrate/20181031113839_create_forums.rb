class CreateForums < ActiveRecord::Migration[5.2]
  def change
    create_table :forums do |t|
      t.string :title
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
