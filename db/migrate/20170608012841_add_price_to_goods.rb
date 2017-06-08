class AddPriceToGoods < ActiveRecord::Migration[5.1]
  def change
    add_column :goods, :price, :string
    add_column :goods, :info, :string
  end
end
