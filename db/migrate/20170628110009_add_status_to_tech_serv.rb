class AddStatusToTechServ < ActiveRecord::Migration[5.1]
  def change
    add_column :tech_servs, :status, :string, :default => '00A'
  end
end
