class AddUserIdToColorPage < ActiveRecord::Migration[5.1]
  def change
    add_column :color_pages, :user_id, :integer
  end
end
