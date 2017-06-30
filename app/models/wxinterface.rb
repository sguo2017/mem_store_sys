class Wxinterface
  require 'net/http'
  require 'net/https'

  def Wxinterface.getAccessToken(code)
  	# puts "wxinterface.getAccessToken call"
    uri = URI.parse(Const::WXConfig::ACCESS_TOKEN_ADDR + "appid=#{Const::WXConfig::APPID}&secret=#{Const::WXConfig::SECRET}&code=#{code}&grant_type=#{Const::WXConfig::GRANT_TYPE}")
    # logger.debug "113 #{uri}"
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    @data = response.body
    # logger.debug "148 #{@data.to_json}"
    return @data #"{\"access_token\":\"SZ3gWcxf7NexY6J4hYTnAVJUeHcKaZPIiQh6BTubFh6fem1rsNCVojMDzIBwGCQW2jB7FLBG4s3JoGvsoBDg8eBnRWwD6DEGnpzvVRy-fJA\",\"expires_in\":7200,\"refresh_token\":\"GUAHQErwGVYw_8WdBdM7HeH0_aMTVbOZZq7WmiKwy4NbOotLplqaon--djMzYLBVxohptcAsJ_t5C0yLmdMR7829tL5OCJjPPfZ_CQHdt4M\",\"openid\":\"oZs6bs43YJNrCDLO5jD6paTg5-5c\",\"scope\":\"snsapi_userinfo\"}"
  end

  def Wxinterface.getUserInfo(params)
  	# puts "wxinterface.getUserInfo call"
    param = JSON.parse(params)
    uri = URI.parse(Const::WXConfig::USER_INFO_ADDR + "access_token=#{param['access_token']}&openid=#{param['openid']}&lang=zh_CN")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    @data = response.body
    @data.force_encoding('UTF-8')
    # logger.debug "162 #{@data.to_json}"
    return @data   
  end

  def Wxinterface.getjsapi_ticket(params)
  	puts "wxinterface.getjsapi_ticket call"
    param = JSON.parse(params)
    uri = URI.parse(Const::WXConfig::JS_TIKET_ADDR + "access_token=#{param['access_token']}&type=jsapi")
    puts "169: #{uri}"
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)
    response = http.request(request)
    @data = response.body
    @data.force_encoding('UTF-8')
    puts "173 #{@data.to_json}"
    session[:jsapi_ticket] = JSON.parse(@data)['ticket']    
    puts "176 #{session[:jsapi_ticket]}"
    # return @data 
  end

end