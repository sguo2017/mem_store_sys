class WeixinConfigInfo < Settingslogic
	PATH = "#{Rails.root}/config/WeixinConfigInfo.yml"
	source PATH
	namespace Rails.env
end