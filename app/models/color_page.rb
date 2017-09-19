# name               活动名称
# begin_time         开始时间
# end_time           结束时间
# profile            活动主题
# avatar             活动图片
# content            活动内容
# accept_users_type  0 => 不发送全部用户, 1 => 发送全部用户
class ColorPage < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
end
