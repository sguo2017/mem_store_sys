class AddReturnMsgToRedPacketHistory < ActiveRecord::Migration[5.1]
  def change
    add_column :red_packet_histories, :return_msg, :string
  end
end
