class AddQrcodeToStore < ActiveRecord::Migration[5.1]
  def change
    add_column :stores, :qrcode, :string
  end
end
