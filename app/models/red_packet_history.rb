class RedPacketHistory < ApplicationRecord
	belongs_to :user, dependent: :destroy
end
