class AddRedPacketToScoreHistories < ActiveRecord::Migration[5.1]
  def change
    add_column :score_histories, :red_packet, :string
  end
end
