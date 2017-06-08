class Good < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
	mount_uploader :info, AvatarUploader
end
