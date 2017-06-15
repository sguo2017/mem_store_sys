class AddAvatarToTechServ < ActiveRecord::Migration[5.1]
  def change
    add_column :tech_servs, :avatar, :string
  end
end
