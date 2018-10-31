class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
