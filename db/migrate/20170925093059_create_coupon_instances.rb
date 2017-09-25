class CreateCouponInstances < ActiveRecord::Migration[5.1]
  def change
    create_table :coupon_instances do |t|
      t.integer :coupon_id
      t.integer :user_id
      t.integer :order_id
      t.string :status
      t.string :code
      t.datetime :write_off_time
      t.integer :write_off_store_id

      t.timestamps
    end
  end
end
