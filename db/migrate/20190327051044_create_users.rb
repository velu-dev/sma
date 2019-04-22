class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :mobile
      t.string :password
      t.string :salt
      t.string :otp

      t.timestamps
    end
  end
end
