class Good < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
	mount_uploader :info, AvatarUploader
	belongs_to :goods_catalog
end
