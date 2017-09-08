class QrCodeScanHistory < ApplicationRecord
	belongs_to :user, dependent: :destroy
	belongs_to :good
end
