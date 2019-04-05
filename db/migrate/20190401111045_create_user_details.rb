class CreateUserDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :user_details do |t|
      t.references :user, foreign_key: true
      t.string :profile_pic
      t.string :designation
      t.string :location

      t.timestamps
    end
  end
end
