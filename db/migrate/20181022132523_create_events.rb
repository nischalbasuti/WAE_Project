class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.time :time_start
      t.time :time_end

      t.timestamps
    end
  end
end
