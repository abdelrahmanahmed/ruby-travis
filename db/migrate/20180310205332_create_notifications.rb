class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :from_user
      t.integer :to_user
      t.integer :status
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
