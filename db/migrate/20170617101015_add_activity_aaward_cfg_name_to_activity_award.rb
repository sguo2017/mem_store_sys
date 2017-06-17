class AddActivityAawardCfgNameToActivityAward < ActiveRecord::Migration[5.1]
  def change
    add_column :activity_awards, :activity_award_cfg_name, :string
  end
end
