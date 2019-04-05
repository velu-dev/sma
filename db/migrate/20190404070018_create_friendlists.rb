class CreateFriendlists < ActiveRecord::Migration[5.2]
  def change
    create_table :friendlists do |t|
      t.references :sender
      t.references :recipient
      t.boolean :is_accepted, :default => false
      t.timestamps
    end
    add_foreign_key :friendlists, :users, column: :sender_id, primary_key: :id
    add_foreign_key :friendlists, :users, column: :recipient_id, primary_key: :id
  end
end
