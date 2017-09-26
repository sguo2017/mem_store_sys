class Coupon < ApplicationRecord
	belongs_to :good
	has_many :coupon_instances
end
