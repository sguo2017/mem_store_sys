class AddColumnCatalogIiiToRedPacketBaseRate < ActiveRecord::Migration[5.1]
  def change
    add_column :red_packet_base_rates, :catalog_iii, :string
  end
end
