class CreateTechServs < ActiveRecord::Migration[5.1]
  def change
    create_table :tech_servs do |t|
      t.text :content

      t.timestamps
    end
  end
end
