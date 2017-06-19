class AddAdminDefaultToActivity < ActiveRecord::Migration[5.1]
  def change
     change_column :activities, :status, :string, :default => "00X"
  end
end
