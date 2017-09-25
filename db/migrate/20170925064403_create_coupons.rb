class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :catalog
      t.string :user_id
      t.integer :good_id
      t.datetime :effect_time
      t.datetime :invalid_time
      t.integer :score
      t.string :status

      t.timestamps
    end
  end
end
