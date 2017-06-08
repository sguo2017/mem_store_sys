class AddLevelToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :level, :string
    add_column :users, :admin, :boolean
    add_column :users, :score, :integer
  end
end
