require 'net/http'  
require 'uri'

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

    sms = SmsSend.where("TIMESTAMPDIFF(MINUTE,created_at ,now())<#{Const::SMS_TIME_LIMIT} and sms_type='code' and recv_num =? and state='00A'", sms_send_params[:recv_num]).first
    
    unless sms.blank?
      @msg = "#{Const::SMS_TIME_LIMIT}分钟内不用重新发送"
      return render json: {status: :created, msg: @msg, retcode: '101'}
    end   

    #历史数据 变更状态位   
    SmsSend.where("recv_num =?",sms_send_params[:recv_num]).update_all(state: "00X")

    @sms_send = SmsSend.new(sms_send_params)
    @sms_send.sms_type='code'

    send_content = rand(1001..9999)     
    @sms_send.send_content = send_content   
	
	info = ConfigInfo["smsconfiginfo"]
    respond_to do |format|
      if @sms_send.save
          add = "#{info["SMS_SEND_URL"]}"
          logger.debug "48 #{add}"
          uri = URI.parse(add)
          http = Net::HTTP.new(uri.host)
          request = Net::HTTP::Post.new(uri.request_uri)
          tpl_val = URI.encode("#code#")  + "=" + URI.encode("#{send_content}");
          data = {apikey:info["SMS_SEND_API_KEY"], 
                  mobile:sms_send_params[:recv_num],
                  tpl_id:info["TPL_ID"],
                  tpl_value:tpl_val
                }
          request.set_form_data(data)
          #request['Content-Type'] = 'application/json;charset=utf-8'
          #request['User-Agent'] = 'Mozilla/5.0 (Windows NT 5.1; rv:29.0) Gecko/20100101 Firefox/29.0'
          #request.body = params.to_json
          response = http.start { |http| http.request(request) }
          # puts response.body.inspect
          # puts JSON.parse response.body


        @msg = "短信发送成功"
        return render json: {status: :created, msg: @msg, retcode: "200"}  
      else
        return render json: {status: :created, msg: @msg, retcode: "102"}
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
