class CreateActivityAwardCfgs < ActiveRecord::Migration[5.1]
  def change
    create_table :activity_award_cfgs do |t|
      t.string :name
      t.string :level_I
      t.integer :score
      t.string :avatar

      t.timestamps
    end
  end
end
