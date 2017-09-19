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

	def scan_redirect
		good_instance_code = params[:good_instance_code]
		info = ConfigInfo["weixinconfiginfo"]
		go_url = "#{info["AUTH_ADDR"]}appid=#{info["APPID"]}&redirect_uri=http://gzb.davco.cn/phone/mem_activations?menu=8%26good_instance_code=#{good_instance_code}&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect"
		redirect_to go_url
	end
end