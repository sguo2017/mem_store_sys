class CreateColorPageAcceptUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :color_page_accept_users do |t|
      t.integer :color_page_id
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
