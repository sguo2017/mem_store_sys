class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.string :code
      t.string :catalog
      t.string :name
      t.string :district
      t.string :city
      t.string :province
      t.string :country
      t.string :latitude
      t.string :longitude
      t.string :addr
      t.string :linkman
      t.string :contact_num

      t.timestamps
    end
  end
end
