class AddStatusToSmsSend < ActiveRecord::Migration[5.1]
  def change
    change_column :sms_sends, :state, :string, :default => "00A"
  end
end
