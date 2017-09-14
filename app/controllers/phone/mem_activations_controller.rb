class Phone::MemActivationsController < PhoneController
  require 'net/http'
  require 'net/https'
  require "json"
  # require "Wxinterface"
  layout "phone"
  before_action :set_mem_activation, only: [:show, :edit, :update, :destroy]

  # GET /phone/mem_activations
  # GET /phone/mem_activations.json
  def index
    @user = current_user
    if @user.nil?
      @user = User.new
    end
    @referee_id = params[:referee_id]
    @menu = params[:menu]
    @store_id = params[:store_id]
    puts "AAAAA#{@store_id}"
    userInfo = session[:userInfo]
    # puts "#CCCC{userInfo["user_id"]}"
    @code = params[:code]
    @user.store_id = @store_id
    @user.save
    puts "DDDD#{@user.id}"
    # from:singlemessage微信分享过来的 ；groupmessage再转分享
    @from = params[:from] 
    goto_url = ""

    case @menu
    when '1' #'1'表示跳转到积分兑换  
      goto_url = phone_bonus_changes_url
    when '2' #'2'表示跳转到积分抽奖
      goto_url = phone_activities_url
    when '3' #'3'表示跳转到优惠券
      goto_url = phone_homepages_url
    when '4' #'4'表示跳转到工长助手
      goto_url = phone_tech_servs_url
    when '5' #'5'表示跳转到会员邀请
      goto_url = phone_invitations_url
    when '6' #'6'表示跳转到附近门店
      goto_url = phone_stores_url + "?from_url=mem_activations" 
    when '7' #'7'表示跳转积分查询
      goto_url = phone_score_queries_url
    when '8' #'8'表示跳转到商品扫码
      code = params[:good_instance_code]
      goto_url = new_phone_score_query_url(:fun_type => "goods_scan",:good_instance_code => code)
    else     #其它情况跳转到主页
      goto_url = phone_homepages_url
    end

    info = ConfigInfo["weixinconfiginfo"]
    # 场景一 授权的没有注册过的用户
    if @from.blank?
      # logger.debug "20 @@@ #{@from}" 
      #获取access_tocken
      access_tocken = Wxinterface.getAccessToken(@code)
      #请求获得jsapi_ticket
      session[:jsapi_ticket] = Wxinterface.getjsapi_ticket()
      #获取用户信息
      userInfo = JSON.parse(Wxinterface.getUserInfo(access_tocken))
      #存量用户
      user = User.where("openid=?",userInfo["openid"]).first
      # logger.debug "21:user #{user.to_json}"
      if user.blank?
        session[:userInfo] = userInfo
        puts(userInfo)
      else 
        user.saveWxUserInfo(userInfo)
        sign_in("user", user)

        respond_to do |format|
          if @store_id.nil?
            format.html { redirect_to goto_url}
          else
            format.html { redirect_to goto_url,notice: '您已成功绑定专卖店！'}
          end
        end
      end  
    else
      # 场景二 分享过来的页面：要做转跳转到授权
      if @from == "singlemessage" or @from == "groupmessage" 
        goto_url = "#{info["AUTH_ADDR"]}appid=#{info["APPID"]}&redirect_uri=http://gzb.davco.cn/phone/mem_activations?menu=#{@menu}&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect"
        respond_to do |format|
          if @store_id.nil?
            format.html { redirect_to goto_url}
          else
            format.html { redirect_to goto_url,notice: '您已成功绑定专卖店！'}
          end
        end
      elsif @from == "self"

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
    # logger.debug "userInfo 55:#{session[:userInfo]} openid:#{session[:userInfo]["openid"]}"                                
    # @phone_num = params[:phone_num]
    @sms_content = params[:sms_content]
    respond_to do |format|
      sms = SmsSend.where("TIMESTAMPDIFF(MINUTE,created_at ,now())<#{Const::SMS_TIME_LIMIT} and sms_type='code' and recv_num =?", mem_activation_params[:phone_num]).first
      if sms.blank?
          @msg = "验证码不存在"
          format.html { redirect_to [:phone, 'mem_activations'], notice: "ma_smscode_not_exist" }
      else 
          if sms.send_content != @sms_content
            @msg = "验证码错误"
            format.html { redirect_to [:phone, 'mem_activations'], notice: "ma_smscode_error" }
           #return render json: {status: :created, msg: @msg}
         else
            userInfo = session[:userInfo];
            #存量用户
            @user = User.where("phone_num=?", mem_activation_params[:phone_num]).first
            unless @user.blank?
              #冻结和注销用户不允许进入首页
              if @user.status ==  '00H' || @user.status ==  '00X'
                @msg = "用户禁止登录"
                puts  @msg
                format.html { redirect_to [:phone, 'mem_activations'],notice: 'ma_deny_user' }
              else
                @user.saveWxUserInfo(userInfo)
                sign_in("user", @user)
                format.html { redirect_to [:phone, 'homepages'],notice: '您已成功绑定专卖店！' }
              end
            else
              #新增用户 
              @user = User.new(mem_activation_params)
              @user.admin = 'false'
              curr_time = rand(100000..999999)  
              @user.email =  Const::SYSTEM_EMAIL + "."+ mem_activation_params[:phone_num] +"."+ curr_time.to_s  #设置默认邮箱，邮箱为非空必须，否则报错
              
              logger.debug "83333 #{session[:userInfo]} city #{userInfo["city"]}"
              mg = MemGroup.find_by_city(userInfo["city"])
              if mg.blank?
                mg = MemGroup.new(city: userInfo["city"],province: userInfo["province"],country: userInfo["country"])
                mg.save
              end
              @user.mem_group_id = mg.id
              @user.password = '123456'
              @user.password_confirmation='123456'

              if @user.save
                @user.saveWxUserInfo(userInfo) 
                sign_in("user", @user)
                @msg = "保存成功"
        			  $config_info.each do |c|
        				  if c.cf_id == "RED_BOUNS_SWITCH"
        					   @switch = c.cf_value
        				  else 
        					   if c.cf_id == "FIRST_LOGIN_RED_BONUS"
        						    @money = c.cf_value
        					   end
        				  end
        			  end
        			  if @switch == 'yes'
        				  @data = Wxinterface.send_redpacket(userInfo,@money)
                  @redpackethistory = RedPacketHistory.new()
                  @redpackethistory.user_id = @user.id
                  @redpackethistory.catalog = "注册送红包活动"
                  @redpackethistory.phone_number = @user.phone_num
                  @redpackethistory.money = @money
                  status = @data.scan(/\<return_msg\>\<\!\[CDATA\[(.*)\]\]\>\<\/return_msg\>/).first.first
                  @redpackethistory.return_msg = status
                  if status == "发放成功"
                    status = "00A"
                  else
                    status = "00X"
                  end
                  @redpackethistory.status = status
                  @redpackethistory.save
        			  end
                if params[:good_instance_code].blank?#普通登录的用户
                  format.html { redirect_to [:phone, 'homepages'],notice: '您已成功注册！' }
                else#扫码进入登录页面的用户
                  format.html { redirect_to new_phone_score_query_url(:fun_type => "goods_scan",:good_instance_code => params[:good_instance_code]) }
                end
              else
                @msg = "保存失败"
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mem_activation
      @mem_activation = MemActivation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mem_activation_params
      # params[:mem_activation]
      params.require(:user).permit(:phone_num, :referee_id, :store_id, :birthday)
    end
end
