class AddTitleToTechServ < ActiveRecord::Migration[5.1]
  def change
    add_column :tech_servs, :title, :string
  end
end
