class RemoveColumnStoreAdminIdIntoUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :store_admin_id
  end
end
