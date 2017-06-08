class RemoveDistrictForMemLevels < ActiveRecord::Migration[5.1]
  def change
     remove_column :mem_levels, :district
  end
end
