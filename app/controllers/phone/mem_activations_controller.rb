class Phone::MemActivationsController < PhoneController
  require 'net/http'
  layout "phone"
  before_action :set_mem_activation, only: [:show, :edit, :update, :destroy]

  # GET /phone/mem_activations
  # GET /phone/mem_activations.json
  def index
    @user = User.new
    @referee_id = params[:referee_id]
    @store_id = params[:store_id]

    @code = params[:code]

    # logger.debug "15 #{@code}"
    # @code = "LWJd+7k3A5bp9ggsh4T0JUGl1iE1iFN7cemXeB2iAjGsMCnkzyC4ptNGg8fytyAehSZc9miaRkLEniQNoqmMpA=="

    # getAccessToken(@code)

    # getJSAccessToken(@code)
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
          unless @user.blank?
            sign_in("user", @user)
            # @msg = "登录成功"
            # puts  @msg
            format.html { redirect_to [:phone, 'homepages'] }
          end
          #新增用户
          @user = User.new(mem_activation_params)
          @user.admin = 'false'
          @user.email =  Const::SYSTEM_EMAIL #设置默认邮箱，邮箱为非空必须，否则报错
          #@user.email = mem_activation_params[:phone_num] + '@qq.com'

          @user.mem_group_id="1"
          @user.password='123456'
          @user.password_confirmation='123456'
          if @user.save
            sign_in("user", @user)
            # @msg = "保存成功"
            # puts  @msg
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
    # uri = URI.parse(Const::WXConfig::ACCESS_TOKEN + "appid=#{Const::WXConfig::APPID}&secret=#{Const::WXConfig::SECRET}&code=#{code}&grant_type=#{Const::WXConfig::GRANT_TYPE}")
    uri = URI.parse(Const::WXConfig::ACCESS_TOKEN + "grant_type=#{Const::WXConfig::GRANT_TYPE}&appid=#{Const::WXConfig::APPID}&secret=#{Const::WXConfig::SECRET}")
    logger.debug "106 #{uri}"
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Post.new(uri.request_uri)
    #request['Content-Type'] = 'application/json;charset=utf-8'
    #request['User-Agent'] = 'Mozilla/5.0 (Windows NT 5.1; rv:29.0) Gecko/20100101 Firefox/29.0'
    #request.body = params.to_json
    response = http.start { |http| http.request(request) }
    logger.debug "112 #{response.body.inspect}"
    logger.debug "113 #{response.body.to_json}"
  end

  def getJSAccessToken(code)
    uri = URI.parse(Const::WXConfig::JS_ACCESS_TOKEN + "access_token=#{code}&type=jsapi")
    logger.debug "106 #{uri}"
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Post.new(uri.request_uri)
    #request['Content-Type'] = 'application/json;charset=utf-8'
    #request['User-Agent'] = 'Mozilla/5.0 (Windows NT 5.1; rv:29.0) Gecko/20100101 Firefox/29.0'
    #request.body = params.to_json
    response = http.start { |http| http.request(request) }
    logger.debug "112 #{response.body.inspect}"
    logger.debug "113 #{response.body.to_json}"
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
