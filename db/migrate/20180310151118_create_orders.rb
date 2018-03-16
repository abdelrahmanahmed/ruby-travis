class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :type
      t.string :orderFrom
      t.string :menuImage
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
