class RemoveColumnUserIdToCoupon < ActiveRecord::Migration[5.1]
  def change
    remove_column :coupons, :user_id, :integer
  end
end
