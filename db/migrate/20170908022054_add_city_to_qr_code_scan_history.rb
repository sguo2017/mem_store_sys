class AddCityToQrCodeScanHistory < ActiveRecord::Migration[5.1]
  def change
    add_column :qr_code_scan_histories, :city, :string
  end
end
