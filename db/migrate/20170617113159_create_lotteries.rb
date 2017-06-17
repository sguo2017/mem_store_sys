class CreateLotteries < ActiveRecord::Migration[5.1]
  def change
    create_table :lotteries do |t|
      t.integer :activity_id
      t.string :activity_name
      t.string :winning
      t.integer :activity_award_id
      t.integer :activity_award_cfg_id
      t.string :activity_award_cfg_name
      t.integer :user_id

      t.timestamps
    end
  end
end
