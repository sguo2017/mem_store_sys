class ChangeDistrictForMemLevels < ActiveRecord::Migration[5.1]
  def change
     add_column :mem_levels, :level, :string
  end
end
