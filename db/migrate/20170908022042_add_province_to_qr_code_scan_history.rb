class AddProvinceToQrCodeScanHistory < ActiveRecord::Migration[5.1]
  def change
    add_column :qr_code_scan_histories, :province, :string
  end
end
