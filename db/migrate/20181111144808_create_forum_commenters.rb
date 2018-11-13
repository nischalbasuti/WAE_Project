class CreateForumCommenters < ActiveRecord::Migration[5.2]
  def change
    create_table :forum_commenters do |t|
      t.references :forum, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
