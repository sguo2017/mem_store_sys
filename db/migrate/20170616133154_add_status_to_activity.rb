class AddStatusToActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :status, :string, :default => '00A'
  end
end
