class CreateColorPages < ActiveRecord::Migration[5.1]
  def change
    create_table :color_pages do |t|
      t.string :name
      t.date :begin_time
      t.date :end_time
      t.string :profile
      t.string :avatar
      t.text :content
      t.integer :accept_users_type

      t.timestamps
    end
  end
end
