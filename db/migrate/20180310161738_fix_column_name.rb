class FixColumnName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :orders, :type, :orderType
  end
end
