class AddDistrictToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :district, 	:string
    add_column :users, :city, 		:string
    add_column :users, :province, 	:string
    add_column :users, :country, 	:string
    add_column :users, :latitude, 	:string
    add_column :users, :longitude, 	:string
    add_column :users, :referee_id, :integer
    add_column :users, :store_id, 	:integer
  end
end
