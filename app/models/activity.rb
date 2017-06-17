class Activity < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
	has_many :activity_awards
end
