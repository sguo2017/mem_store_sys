class AddColumnObjectToRedPacketHistory < ActiveRecord::Migration[5.1]
  def change
    add_column :red_packet_histories, :obj_type, :string
    add_column :red_packet_histories, :obj_id, :integer
  end
end
