class RemoveColumnReturnStoreIdIntoUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :return_store_id
  end
end
