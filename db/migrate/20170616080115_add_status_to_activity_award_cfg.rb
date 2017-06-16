class AddStatusToActivityAwardCfg < ActiveRecord::Migration[5.1]
  def change
    add_column :activity_award_cfgs, :status, :string , :default => '00A'
  end
end
