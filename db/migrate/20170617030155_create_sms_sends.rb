class CreateSmsSends < ActiveRecord::Migration[5.1]
  def change
    create_table :sms_sends do |t|
      t.string :recv_num
      t.string :send_content
      t.string :state
      t.string :sms_type
      t.integer :user_id

      t.timestamps
    end
  end
end
