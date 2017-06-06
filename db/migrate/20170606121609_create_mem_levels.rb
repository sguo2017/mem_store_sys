class CreateMemLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :mem_levels do |t|
      t.string :code
      t.string :name
      t.string :district
      t.integer :score

      t.timestamps
    end
  end
end
