class CreateRedPacketHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :red_packet_histories do |t|
      t.integer :user_id
      t.integer :money
      t.string :catalog
      t.string :phone_number
      t.string :status

      t.timestamps
    end
  end
end
