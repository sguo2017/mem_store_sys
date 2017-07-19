class ConfigInfo < Settingslogic
	PATH = "#{Rails.root}/config/ConfigInfo.yml"
	source PATH
	namespace Rails.env
end