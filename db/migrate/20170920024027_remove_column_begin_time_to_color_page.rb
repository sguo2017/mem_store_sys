class RemoveColumnBeginTimeToColorPage < ActiveRecord::Migration[5.1]
  def change
    remove_column :color_pages, :begin_time, :string
  end
end
