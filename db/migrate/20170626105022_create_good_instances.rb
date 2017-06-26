class CreateGoodInstances < ActiveRecord::Migration[5.1]
  def change
    create_table :good_instances do |t|
      t.string :code
      t.integer :good_id
      t.string :status

      t.timestamps
    end
  end
end
