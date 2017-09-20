class RemoveColumnEndTimeToColorPage < ActiveRecord::Migration[5.1]
  def change
    remove_column :color_pages, :end_time, :string
  end
end
