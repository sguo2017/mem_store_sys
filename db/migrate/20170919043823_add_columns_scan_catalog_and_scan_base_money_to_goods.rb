class AddColumnsScanCatalogAndScanBaseMoneyToGoods < ActiveRecord::Migration[5.1]
  def change
    add_column :goods, :scan_catalog, :string
    add_column :goods, :scan_base_money, :integer
  end
end
