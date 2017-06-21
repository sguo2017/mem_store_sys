class Phone::MemActivationsController < PhoneController
  layout "phone"
  before_action :set_mem_activation, only: [:show, :edit, :update, :destroy]

  # GET /phone/mem_activations
  # GET /phone/mem_activations.json
  def index
    @user = User.new
    @referee_id = params[:referee_id]
    @store_id = params[:store_id]
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
        format.html { redirect_to [:phone, 'mem_activations'], notice: @msg }
        puts  @msg
      else 
        if sms.send_content != @sms_content
          @msg = "验证码错误"
          format.html { redirect_to [:phone, 'mem_activations'], notice: @msg }
          puts  @msg
         #return render json: {status: :created, msg: @msg}
       else
          #存量用户
          @user = User.where("phone_num=?", mem_activation_params[:phone_num]).first
          unless @user.blank?
            sign_in("user", @user)
            @msg = "登录成功"
            puts  @msg
            format.html { redirect_to [:phone, 'homepages'] }
          end
          #新增用户
          @user = User.new(mem_activation_params)
          @user.admin = 'false'
          @user.email = mem_activation_params[:phone_num] + '@qq.com'
          @user.mem_group_id="1"
          @user.password='123456'
          @user.password_confirmation='123456'
          if @user.save
            sign_in("user", @user)
            @msg = "保存成功"
            puts  @msg
            format.html { redirect_to [:phone, 'homepages'] }
          else
            @msg = "保存失败"
            puts  @msg
            format.html { redirect_to [:phone, 'mem_activations'],notice: '保存失败.' }
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
      params.require(:user).permit(:phone_num, :referee_id, :store_id)
    end
end
