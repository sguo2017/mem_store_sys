class CreateStoresUsersJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table :stores_users, id: false do |t|
      t.integer :store_id
      t.integer :user_id
    end
 
    add_index :stores_users, :store_id
    add_index :stores_users, :user_id
  end
end
