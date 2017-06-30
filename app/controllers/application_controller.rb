class ApplicationController < ActionController::Base
	#protect_from_forgery with: :exception
	before_action :add_cors_headers

	def add_cors_headers
	  origin = request.headers["Origin"]
	  # logger.debug "17 #{origin}"
	  unless (not origin.nil?) and (origin == "http://gzb.davco.cn" or origin.starts_with? "http://localhost:")
	    origin = "http://127.0.0.1"
	  end
	  headers['Access-Control-Allow-Origin'] = origin
	  headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, DELETE'
	  allow_headers = request.headers["Access-Control-Request-Headers"]
	  if allow_headers.nil?
	    #shouldn't happen, but better be safe
	    allow_headers = 'Origin, Authorization, Accept, Content-Type'
	  end
	  headers['Access-Control-Allow-Headers'] = allow_headers
	  headers['Access-Control-Allow-Credentials'] = 'true'
	  headers['Access-Control-Max-Age'] = '1728000'
	end

end
