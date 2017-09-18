class AddStoreIdToColoerPage < ActiveRecord::Migration[5.1]
  def change
    add_column :color_pages, :store_id, :integer
  end
end
