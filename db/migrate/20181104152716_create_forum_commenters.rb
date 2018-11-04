class CreateForumCommenters < ActiveRecord::Migration[5.2]
  def change
    create_table :forum_commenters do |t|
      t.references :user, foreign_key: true
      t.references :forum, foreign_key: true

      t.timestamps
    end
  end
end
