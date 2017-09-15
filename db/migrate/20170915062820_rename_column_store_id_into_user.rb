class RenameColumnStoreIdIntoUser < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :store_id, :store_admin_id
  end
end
