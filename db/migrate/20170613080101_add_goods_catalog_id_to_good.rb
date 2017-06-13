class AddGoodsCatalogIdToGood < ActiveRecord::Migration[5.1]
  def change
    add_column :goods, :goods_catalog_id, :integer
  end
end
