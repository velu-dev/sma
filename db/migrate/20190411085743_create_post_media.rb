class CreatePostMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :post_media do |t|
      t.string :media
      t.string :media_type
      t.references :post, foreign_key: true, optional: true

      t.timestamps
    end
  end
end
