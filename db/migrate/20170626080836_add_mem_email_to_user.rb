class AddMemEmailToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :mem_email, :string, :default => ""
  end
end
