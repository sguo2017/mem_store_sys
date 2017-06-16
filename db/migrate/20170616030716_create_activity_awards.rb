class CreateActivityAwards < ActiveRecord::Migration[5.1]
  def change
    create_table :activity_awards do |t|
      t.string :catalog
      t.integer :rate
      t.integer :activity_award_cfg_id
      t.integer :activity_base_id

      t.timestamps
    end
  end
end
