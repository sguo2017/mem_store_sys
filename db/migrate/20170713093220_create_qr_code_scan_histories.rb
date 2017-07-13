class CreateQrCodeScanHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :qr_code_scan_histories do |t|
      t.integer :user_id
      t.integer :good_id
      t.integer :good_instance_id
      t.integer :score
      t.string :status

      t.timestamps
    end
  end
end
