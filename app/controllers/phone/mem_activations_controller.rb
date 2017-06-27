class Phone::MemActivationsController < PhoneController
  require 'net/http'
  require 'net/https'
  require "json"
  layout "phone"
  before_action :set_mem_activation, only: [:show, :edit, :update, :destroy]

  # GET /phone/mem_activations
  # GET /phone/mem_activations.json
  def index
    @user = User.new
    @referee_id = params[:referee_id]
    @store_id = params[:store_id]
    @code = params[:code]
    #获取access_tocken
    access_tocken = getAccessToken(@code)
    #获取用户信息
    userInfo = JSON.parse(getUserInfo(access_tocken))
    #存量用户
    user = User.where("openid=?",userInfo["openid"]).first
    # logger.debug "21:user #{user.to_json}"
    if user.blank?
      session[:userInfo] = userInfo
    else 
      #
      user.headimgurl = userInfo["headimgurl"]
      user.nickname = userInfo["nickname"]
      user.language = userInfo["language"]
      user.save
      #
      sign_in("user", user)
      respond_to do |format|
        format.html { redirect_to [:phone, 'homepages'] }
      end
    end  

 end
  # GET /phone/mem_activations/1
  # GET /phone/mem_activations/1.json
  def show
  end

  # GET /phone/mem_activations/new
  def new
    #@mem_activation = MemActivation.new
  end

  # GET /phone/mem_activations/1/edit
  def edit
  end

  # POST /phone/mem_activations
  # POST /phone/mem_activations.json
  def create
    logger.debug "userInfo 55:#{session[:userInfo]} openid:#{session[:userInfo]["openid"]}"                      
            
    # @phone_num = params[:phone_num]
    @sms_content = params[:sms_content]
    respond_to do |format|
      sms = SmsSend.where("TIMESTAMPDIFF(MINUTE,created_at ,now())<#{Const::SMS_TIME_LIMIT} and sms_type='code' and recv_num =?", mem_activation_params[:phone_num]).first
      if sms.blank?
          @msg = "验证码不存在"
          format.html { redirect_to [:phone, 'mem_activations'], notice: "ma_smscode_not_exist" }
          puts  @msg
      else 
          if sms.send_content != @sms_content
            @msg = "验证码错误"
            format.html { redirect_to [:phone, 'mem_activations'], notice: "ma_smscode_error" }
            puts  @msg
           #return render json: {status: :created, msg: @msg}
         else
            #存量用户
            @user = User.where("phone_num=?", mem_activation_params[:phone_num]).first
            logger.debug "74"
            unless @user.blank?
              @user.openid = session[:userInfo]["openid"]
              @user.headimgurl = session[:userInfo]["headimgurl"]
              @user.nickname = session[:userInfo]["nickname"]
              @user.language = session[:userInfo]["language"] 
              @user.save
              sign_in("user", @user)
              @msg = "登录成功"
              puts  @msg
              format.html { redirect_to [:phone, 'homepages'] }
            else
              logger.debug "87"
              #新增用户
              @user = User.new(mem_activation_params)
              @user.admin = 'false'
              curr_time = rand(100000..999999)  
              @user.email =  Const::SYSTEM_EMAIL + "."+ mem_activation_params[:phone_num] +"."+ curr_time.to_s  #设置默认邮箱，邮箱为非空必须，否则报错

              @user.mem_group_id="1"
              @user.password='123456'
              @user.password_confirmation='123456'

              @user.openid = session[:userInfo]["openid"]
              @user.headimgurl = session[:userInfo]["headimgurl"]
              @user.nickname = session[:userInfo]["nickname"]
              @user.language = session[:userInfo]["language"]  
              if @user.save
                sign_in("user", @user)
                @msg = "保存成功"
                puts  @msg
                format.html { redirect_to [:phone, 'homepages'] }
              else
                @msg = "保存失败"
                puts  @msg
                format.html { redirect_to [:phone, 'mem_activations'],notice: 'ma_save_fail' }
              end
            end
        end
      end  
    end

  end

  # PATCH/PUT /phone/mem_activations/1
  # PATCH/PUT /phone/mem_activations/1.json
  def update
    respond_to do |format|
      if @mem_activation.update(mem_activation_params)
        format.html { redirect_to [:phone, @mem_activation], notice: 'Mem activation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mem_activation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/mem_activations/1
  # DELETE /phone/mem_activations/1.json
  def destroy
    @mem_activation.destroy
    respond_to do |format|
      format.html { redirect_to phone_mem_activations_url, notice: 'Mem activation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def getAccessToken(code)
    uri = URI.parse(Const::WXConfig::ACCESS_TOKEN_ADDR + "appid=#{Const::WXConfig::APPID}&secret=#{Const::WXConfig::SECRET}&code=#{code}&grant_type=#{Const::WXConfig::GRANT_TYPE}")
    # logger.debug "113 #{uri}"
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    @data = response.body
    logger.debug "120 #{@data.to_json}"

    return @data #"{\"access_token\":\"SZ3gWcxf7NexY6J4hYTnAVJUeHcKaZPIiQh6BTubFh6fem1rsNCVojMDzIBwGCQW2jB7FLBG4s3JoGvsoBDg8eBnRWwD6DEGnpzvVRy-fJA\",\"expires_in\":7200,\"refresh_token\":\"GUAHQErwGVYw_8WdBdM7HeH0_aMTVbOZZq7WmiKwy4NbOotLplqaon--djMzYLBVxohptcAsJ_t5C0yLmdMR7829tL5OCJjPPfZ_CQHdt4M\",\"openid\":\"oZs6bs43YJNrCDLO5jD6paTg5-5c\",\"scope\":\"snsapi_userinfo\"}"
  end

  def getUserInfo(params)
    param = JSON.parse(params)
    logger.debug "125 #{param['access_token']}"
    uri = URI.parse(Const::WXConfig::USER_INFO_ADDR + "access_token=#{param['access_token']}&openid=#{param['openid']}&lang=zh_CN")
    logger.debug "127 #{uri}"
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    @data = response.body
    @data.force_encoding('UTF-8')
    logger.debug "134 #{@data.to_json}"
    return @data   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mem_activation
      @mem_activation = MemActivation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mem_activation_params
      # params[:mem_activation]
      params.require(:user).permit(:phone_num, :referee_id, :store_id)
    end
end
