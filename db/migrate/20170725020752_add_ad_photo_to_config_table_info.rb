class AddAdPhotoToConfigTableInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :config_table_infos, :ad_photo, :string
  end
end
