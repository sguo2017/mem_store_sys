class AddColumnTimeToColorPage < ActiveRecord::Migration[5.1]
  def change
    add_column :color_pages, :time, :string
  end
end
