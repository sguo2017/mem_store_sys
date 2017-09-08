class ShortUrlsController < ApplicationController
	def redirect
		short_url = params[:url]
		key = ShortUrl.b64dec(short_url)
		if key == -1
			response.status = 404
		else
			value = ShortUrl.find(key)
			redirect_to value.value
		end
	end
end