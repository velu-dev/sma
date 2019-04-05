class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :sentby
      t.references :receivedby
      t.references :post
      t.references :like
      t.references :comment
      t.references :notify_type
      t.boolean :is_read, :default => false
      t.timestamps
    end
    add_foreign_key :notifications, :users, column: :sentby_id, primary_key: :id
    add_foreign_key :notifications, :users, column: :receivedby_id, primary_key: :id
  end
end
