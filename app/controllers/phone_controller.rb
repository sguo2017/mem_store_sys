class PhoneController < ApplicationController
	# before_action :authenticate_user

	def self_authenticate_user
		$request = request
		# logger.debug " 6  "
		# logger.debug " 6  #{$request.original_url.to_s}"
		# logger.debug " 6  #{$request.request_method.to_s}"
		unless $request.original_url().index("/phone/mem_activations") > 0
			authenticate_user!
		end
	end
end
