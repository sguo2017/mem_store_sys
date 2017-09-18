class CreateRedPacketBaseRates < ActiveRecord::Migration[5.1]
  def change
    create_table :red_packet_base_rates do |t|
      t.string :catalog_i
      t.integer :catalog_ii
      t.integer :val
      t.integer :rate

      t.timestamps
    end
  end
end
