class Phone::SmsSendsController < PhoneController
  before_action :set_sms_send, only: [:show, :edit, :update, :destroy]

  # GET /phone/sms_sends
  # GET /phone/sms_sends.json
  def index
    @sms_sends = SmsSend.all
  end

  # GET /phone/sms_sends/1
  # GET /phone/sms_sends/1.json
  def show
  end

  # GET /phone/sms_sends/new
  def new
    @sms_send = SmsSend.new
  end

  # GET /phone/sms_sends/1/edit
  def edit
  end

  # POST /phone/sms_sends
  # POST /phone/sms_sends.json
  def create
    @msg = "短信发送失败"

    sms = SmsSend.where("TIMESTAMPDIFF(MINUTE,created_at ,now())<#{Const::SMS_TIME_LIMIT} and sms_type='code' and recv_num =?", sms_send_params[:recv_num]).first
    
    unless sms.blank?
      @msg = "#{Const::SMS_TIME_LIMIT}分钟内不用重新发送"
      return render json: {status: :created, msg: @msg}
    end    

    @sms_send = SmsSend.new(sms_send_params)
    @sms_send.sms_type='code'

    send_content = rand(9999)     
    @sms_send.send_content = send_content   

    respond_to do |format|
      if @sms_send.save
        @msg = "短信发送成功#{send_content}"
        return render json: {status: :created, msg: @msg}  
      else
        return render json: {status: :created, msg: @msg}
      end
    end
  end

  # PATCH/PUT /phone/sms_sends/1
  # PATCH/PUT /phone/sms_sends/1.json
  def update
    respond_to do |format|
      if @sms_send.update(sms_send_params)
        format.html { redirect_to [:phone, @sms_send], notice: 'Sms send was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sms_send.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/sms_sends/1
  # DELETE /phone/sms_sends/1.json
  def destroy
    @sms_send.destroy
    respond_to do |format|
      format.html { redirect_to phone_sms_sends_url, notice: 'Sms send was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sms_send
      @sms_send = SmsSend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sms_send_params
      params.require(:sms_send).permit(:recv_num, :send_content, :state, :sms_type, :user_id)
    end
end
