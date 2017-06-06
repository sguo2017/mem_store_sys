class CreateGoods < ActiveRecord::Migration[5.1]
  def change
    create_table :goods do |t|
      t.string :code
      t.string :name
      t.string :goods_catalog
      t.string :spec
      t.string :status
      t.integer :score
      t.boolean :ispromotion
      t.string :avatar

      t.timestamps
    end
  end
end
