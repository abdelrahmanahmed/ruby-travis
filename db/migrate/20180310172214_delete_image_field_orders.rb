class DeleteImageFieldOrders < ActiveRecord::Migration[5.1]
  def change
  	remove_column :orders, :menuImage
  end
end
