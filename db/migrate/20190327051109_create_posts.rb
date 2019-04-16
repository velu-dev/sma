class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :content
      t.string :tags, array: true
      t.string :location
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :posts, :tags, using: "gin"
  end
end
