class CreateBonusChanges < ActiveRecord::Migration[5.1]
  def change
    create_table :bonus_changes do |t|
      t.integer :score
      t.integer :red_packet

      t.timestamps
    end
  end
end
