class CreateChatRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms do |t|
      t.string :room_name
      t.references :user, foreign_key: true, optional: true
      t.references :first_user
      t.references :second_user
      t.boolean :is_group
      t.boolean :is_private
      t.timestamps
    end
    add_foreign_key :chat_rooms, :users, column: :first_user_id, primary_key: :id
    add_foreign_key :chat_rooms, :users, column: :second_user_id, primary_key: :id
  end
end
