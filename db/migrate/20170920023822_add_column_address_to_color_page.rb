class AddColumnAddressToColorPage < ActiveRecord::Migration[5.1]
  def change
    add_column :color_pages, :address, :string
  end
end
