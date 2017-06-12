class AddMemGroupIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :mem_group_id, :integer
  end
end
