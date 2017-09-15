class WelcomeController < AdminController
	skip_load_and_authorize_resource
  def index
  	#@user = User.find(176)
  	#active_url = "http://gzb.davco.cn/phone/activities"
  	#Wxinterface.send_template_message_active_notice(@user,active_url,"活动名称XXX","活动时间XXX","活动地点XXX")
  end
end
