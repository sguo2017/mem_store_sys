# name               活动名称
# time         		 活动时间
# profile            活动主题
# avatar             活动图片
# content            活动内容
# adress			 活动地点
# accept_users_type  0 => 不发送全部用户, 1 => 发送全部用户
class ColorPage < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
	before_save :default_values
	  def default_values
	  end
end
