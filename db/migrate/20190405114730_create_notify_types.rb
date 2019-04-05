class CreateNotifyTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :notify_types do |t|
      t.string :notify_type
      t.string :desc

      t.timestamps
    end
  end
end
