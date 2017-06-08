class AddSexToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :sex, :string
    add_column :users, :birthday, :date
    add_column :users, :phone_num, :string
  end
end
