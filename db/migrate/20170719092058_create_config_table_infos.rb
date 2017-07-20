class CreateConfigTableInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :config_table_infos do |t|
      t.string :cf_id
      t.string :cf_desc
      t.string :cf_value

      t.timestamps
    end
  end
end
