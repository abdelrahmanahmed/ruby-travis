class RenameDestroyColumn < ActiveRecord::Migration[5.1]
  def change
  	rename_column :friendships, :destroy, :destroyat
  	rename_column :friendships, :create, :createdat
  end
end
