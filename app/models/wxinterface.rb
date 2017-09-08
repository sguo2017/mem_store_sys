class Wxinterface
  require 'net/http'
  require 'net/https'
  require "json"

  def Wxinterface.getAccessToken(code)
	info = ConfigInfo["weixinconfiginfo"]
  	# puts "wxinterface.getAccessToken call"
    uri = URI.parse(info["ACCESS_TOKEN_ADDR"] + "appid=#{info["APPID"]}&secret=#{info["SECRET"]}&code=#{code}&grant_type=#{Const::WXConfig::GRANT_TYPE}")
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
	info = ConfigInfo["weixinconfiginfo"]
    param = JSON.parse(params)
    uri = URI.parse(info["USER_INFO_ADDR"] + "access_token=#{param['access_token']}&openid=#{param['openid']}&lang=zh_CN")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    @data = response.body
    @data.force_encoding('UTF-8')
    # puts "EEEEEE　#{@data.to_json}"
    return @data   
  end

  def Wxinterface.global_access_token
	info = ConfigInfo["weixinconfiginfo"]
    if $access_token_effect_time == nil || (Time.now-$access_token_effect_time)>1.hour
      uri = URI.parse(info["GLOBAL_ACCESS_TOKEN_ADDR"] + "grant_type=client_credential&appid=#{info["APPID"]}&secret=#{info["SECRET"]}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new(uri.request_uri)
      response = http.request(request)
      @data = response.body
      @data.force_encoding('UTF-8')
      puts "50 #{@data.to_json}"
      $access_token = JSON.parse(@data)['access_token']   
      $access_token_effect_time = Time.now
    end
    # session[:jsapi_ticket] = JSON.parse(@data)['ticket']    
    # puts "176 #{session[:jsapi_ticket]}"
    # return @data    
  end

  def Wxinterface.getjsapi_ticket()
	info = ConfigInfo["weixinconfiginfo"]
    Wxinterface.global_access_token()
    uri = URI.parse(info["JS_TIKET_ADDR"] + "access_token=#{$access_token}&type=jsapi")
    puts "169: #{uri}"
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)
    response = http.request(request)
    @data = response.body
    @data.force_encoding('UTF-8')
    puts "71 #{@data.to_json}" #"{\"errcode\":0,\"errmsg\":\"ok\",\"ticket\":\"sM4AOVdWfPE4DxkXGEs8VPHC6PkRrUTMm9L913Q0hTlkYsOYfpAjf9VQaukqSypUrVsU3cDmzApPUAL_DSE7AA\",\"expires_in\":7200}"
    return JSON.parse(@data)['ticket'] 
  end

  def Wxinterface.send_redpacket(user_info,money)
    #各项参数
	info = ConfigInfo["weixinconfiginfo"]
    act_name = "Register_to_send_red_packets"  #活动名称
    client_ip = info["CLIENT_IP"]  #调用接口的机器Ip地址
    mch_billno =  DateTime.now.to_s(:number) + DateTime.now.to_i.to_s#商户订单号
    mch_id = info["MCH_ID"]  #商户号
    #生成随机字符串
    o = [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten 
    nonce_str = (0...20).map{ o[rand(o.length)] }.join
    re_openid = user_info["openid"]  #接受红包的用户
    remark = "no"  #备注信息
    send_name = info["SEND_NAME"]  #商户名称
    total_amount = money  #付款金额(单位为分)
    total_num = 1  #红包发放总人数
    wishing = "welcome"  #红包祝福语
    wxappid = info["APPID"]  #公众账号appid

    #生成签名
    stringA = "act_name=#{act_name}&client_ip=#{client_ip}&mch_billno=#{mch_billno}&mch_id=#{mch_id}&nonce_str=#{nonce_str}&re_openid=#{re_openid}&remark=#{remark}&send_name=#{send_name}&total_amount=#{total_amount}&total_num=#{total_num}&wishing=#{wishing}&wxappid=#{wxappid}"
    stringSignTemp = "#{stringA}&key=#{info["KEY"]}"
	puts "stringSignTemp: #{stringSignTemp}"
    sign = Digest::MD5.hexdigest(stringSignTemp).upcase

    body_content = ""
    body_content = body_content + "<xml>"
    body_content = body_content + "<act_name>#{act_name}</act_name>"
    body_content = body_content + "<client_ip>#{client_ip}</client_ip>"
    body_content = body_content + "<mch_billno>#{mch_billno}</mch_billno>"
    body_content = body_content + "<mch_id>#{mch_id}</mch_id>"
    body_content = body_content + "<nonce_str>#{nonce_str}</nonce_str>"
    body_content = body_content + "<re_openid>#{re_openid}</re_openid>"
    body_content = body_content + "<remark>#{remark}</remark>"
    body_content = body_content + "<send_name>#{send_name}</send_name>"
    body_content = body_content + "<total_amount>#{total_amount}</total_amount>"
    body_content = body_content + "<total_num>#{total_num}</total_num>"
    body_content = body_content + "<wishing>#{wishing}</wishing>"
    body_content = body_content + "<wxappid>#{wxappid}</wxappid>"
    body_content = body_content + "<sign>#{sign}</sign>"
    body_content = body_content + "</xml>"
    uri = URI.parse(info["RED_PACKET_ADDR"])
    puts "send_redpacket: #{uri}"
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
	http.cert =OpenSSL::X509::Certificate.new(File.read("#{Rails.root}/config/apiclient_cert.pem"))
	http.key =OpenSSL::PKey::RSA.new((File.read("#{Rails.root}/config/apiclient_key.pem")), mch_id)# key and password
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)
	request.body = body_content
	puts "body_content: #{body_content}"
    response = http.request(request)
    @data = response.body
    @data.force_encoding('UTF-8')
    return @data
  end

  def Wxinterface.get_industry()
    info = ConfigInfo["weixinconfiginfo"]
    Wxinterface.global_access_token()
    uri = URI.parse(info["GET_INDUSTRY_ADDR"]+"access_token=#{$access_token}")
    puts "132: #{uri}"
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    @data = response.body
    @data.force_encoding('UTF-8')
    puts "140 #{@data}"
    return JSON.parse(@data)['ticket'] 
  end

  def Wxinterface.get_all_private_template()
    info = ConfigInfo["weixinconfiginfo"]
    Wxinterface.global_access_token()
    uri = URI.parse(info["GET_ALL_PRIVATE_TEMPLATE_ADDR"]+"access_token=#{$access_token}")
    puts "132: #{uri}"
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    @data = response.body
    @data.force_encoding('UTF-8')
    puts "154 #{@data}"
    return JSON.parse(@data)['ticket'] 
  end

  def Wxinterface.send_template_message_score(user_info,socre_change,score_type)
    data = {
           "touser": user_info["openid"],
           "template_id": "fggQR64tbFOksCBV8Nqt0V70KExuDOyYsg0PlZmOyow",        
           "data":{
                   "first": {
                       "value": "亲爱的#{user_info['name']}，您的积分账户有新的变动，具体内容如下：",
                       "color": "#173177"
                   },
                   "keyword1":{
                       "value": Time.now.strftime('%Y年-%m月-%d日 %H时:%M分'),
                       "color": "#173177"
                   },
                   "keyword2": {
                       "value": socre_change,
                       "color": "#173177"
                   },
                   "keyword3": {
                       "value": score_type,
                       "color": "#173177"
                   },
                   "keyword4": {
                       "value": user_info["score"],
                       "color": "#173177"
                   },
                   "remark":{
                       "value": "欢迎再次参与！",
                       "color": "#173177"
                   }
           }
       }
    Wxinterface.send_template_message(data)
  end

  def Wxinterface.send_template_message_gift_exchange(user_info,gift_name,score_consumed)
    data = {
           "touser": user_info["openid"],
           "template_id": "CPgWVvuZHalzOoxRyyNPPU4TL68Ff-DPiXIajmm85oM",        
           "data":{
                   "first": {
                       "value": "亲爱的#{user_info['name']}，您的奖品兑换成功：",
                       "color": "#173177"
                   },
                   "keyword1":{
                       "value": gift_name,
                       "color": "#173177"
                   },
                   "keyword2": {
                       "value": score_consumed,
                       "color": "#173177"
                   },
                   "keyword3": {
                       "value": user_info["score"],
                       "color": "#173177"
                   },
                   "keyword4": {
                       "value": Time.now.strftime('%Y年-%m月-%d日 %H时:%M分'),
                       "color": "#173177"
                   },
                   "remark":{
                       "value": "欢迎再次参与！",
                       "color": "#173177"
                   }
           }
       }
    Wxinterface.send_template_message(data)
  end

  def Wxinterface.send_template_message_profile_changed(user_info,detail,effect_time)
    data = {
           "touser": user_info["openid"],
           "template_id": "GvUHMI1-78LuDhhf28qvFrMi6to8pn3-YGXzdIzIHTE",        
           "data":{
                   "first": {
                       "value": "亲爱的#{user_info['name']}，您的信息变更成功：",
                       "color": "#173177"
                   },
                   "keyword1":{
                       "value": "会员卡号",
                       "color": "#173177"
                   },
                   "keyword2": {
                       "value": Time.now.strftime('%Y年-%m月-%d日 %H时:%M分'),
                       "color": "#173177"
                   },
                   "keyword3": {
                       "value": detail,
                       "color": "#173177"
                   },
                   "keyword4": {
                       "value": effect_time.strftime('%Y年-%m月-%d日 %H时:%M分'),
                       "color": "#173177"
                   },
                   "remark":{
                       "value": "感谢您长期以来对本平台的认可与支持，您的信赖，是我们进步的唯一动力！",
                       "color": "#173177"
                   }
           }
       }
    Wxinterface.send_template_message(data)
  end

  def Wxinterface.send_template_message(data)
    info = ConfigInfo["weixinconfiginfo"]
    Wxinterface.global_access_token()
    uri = URI.parse(info["SEND_TEMPLATE_MESSAGE_ADDR"]+"access_token=#{$access_token}")
    puts "192: #{uri}"
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = data.to_json
    response = http.request(request)
    @data = response.body
    @data.force_encoding('UTF-8')
    puts "173 #{@data}"
  end

  def Wxinterface.get_user_info_unionID(openid)
    info = ConfigInfo["weixinconfiginfo"]
    Wxinterface.global_access_token()
    uri = URI.parse(info["USER_INFO_UNIONID_ADDR"]+"access_token=#{$access_token}&openid=#{openid}")    
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    @data = response.body
    @data.force_encoding('UTF-8')
    puts "140 #{@data}"
    @data = JSON.parse(@data)
    return @data
  end
end