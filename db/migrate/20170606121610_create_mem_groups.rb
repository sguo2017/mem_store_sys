class CreateMemGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :mem_groups do |t|
      t.string :city
      t.string :province
      t.string :country

      t.timestamps
    end
  end
end
