class ConfigTableInfo < ApplicationRecord
	$config_info
	after_save :reload_cfg_info
	after_create :reload_cfg_info
	mount_uploader :ad_photo, AvatarUploader
	
	def reload_cfg_info
		ConfigTableInfo.config_table_info_init
	end	
	
	def ConfigTableInfo.config_table_info_init
		$config_info = ConfigTableInfo.all
		#puts $config_info.to_json
		#return $config_info
	end
end
