class RemoveGoodsCatalogFromGoods < ActiveRecord::Migration[5.1]
  def change
    remove_column :goods, :goods_catalog, :string
  end
end
