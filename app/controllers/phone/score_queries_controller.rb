class Phone::ScoreQueriesController < PhoneController
  # before_action :authenticate_user!
  layout "phone"
  before_action :set_score_query, only: [:show, :edit, :update, :destroy]

  # GET /phone/score_queries
  # GET /phone/score_queries.json
  def index
    @user = current_user
    # @score_queries = @user.score_histories.order("created_at DESC")
    @score_queries_up = @user.score_histories.where(:oper=>'获得').order("created_at DESC")
    @score_queries_down = @user.score_histories.where(:oper=>'扣减').order("created_at DESC")
    @pay_type = params[:pay_type]
    @up_total = point_total(@score_queries_up)
    @down_total = point_total(@score_queries_down)
    @bonus_change_redPacket = params[:packet_money]
    @fun_type = params[:oper_type]
    @get_score = params[:add_score]
  end


  # GET /phone/score_queries/1
  # GET /phone/score_queries/1.json
  def show

  end

  # GET /phone/score_queries/new
  # 两种场景：
  # 1、积分兑换           fun_type == "bonus_change"
  # 2、商品实例扫码送积分 fun_type == "goods_scan"
  # 3、未登录             fun_type == "no_login"
  def new
    fun_type = params[:fun_type] #必填字段，不允许为空
    @user = current_user
    if @user.blank?
        fun_type = "no_login"
    end

    case fun_type
    when "goods_scan" #商品实例->商品->积分
      @scan_query = QrCodeScanHistory.new()

      @good_instance = GoodInstance.where(:code =>params[:code]).first
      good = Good.where(:id =>@good_instance.good_id).first

      @scan_query.user_id = @user.id
      @scan_query.good_id = good.id
      @scan_query.good_instance_id = @good_instance.id
      @scan_query.score = good.score

      if @good_instance.status == '00A'
        @add_score = params[:score_history][:point] = good.score
        @user.changeScore(@add_score) #会员积分变化
        params[:score_history][:user_id] = @user.id
        # params[:score_history][:oper] = "获得"
        # params[:score_history][:bonus_change_id] = '1'
        @score_query = ScoreHistory.new(score_history_params)
        @score_query.object_type = "商品扫码"
        @score_query.save
        
        

        @good_instance.status = '00X'
        @good_instance.save
        @msg = "扫码送积分操作成功"
        @go_url = phone_score_queries_url(pay_type: 'up', add_score: @add_score ,oper_type: fun_type)

        @scan_query.status = '00A'


      else
        @msg = "商品积分已兑换过"
        @go_url = phone_homepages_url

        @scan_query.status = '00X'
      end

      @scan_query.save
    when "bonus_change" #积分扣减送红包
      @add_score = -(params[:score_history][:point].presence.to_i)
      #扣减积分不够
      if @user.score + @add_score >= 0
        @user.changeScore(@add_score) #会员积分变化
        params[:score_history][:user_id] = @user.id
        @score_query = ScoreHistory.new(score_history_params)
        @score_query.object_type = "兑换红包"
        @score_query.save!
        @msg = "积分兑换成功"
        @bonus_change_score= params[:score_history][:red_packet]
        # @go_url = '/phone/score_queries?pay_type=down'
        @go_url = phone_score_queries_url(pay_type: 'down', packet_money: @bonus_change_score ,oper_type: fun_type)
      else
        @msg = "积分兑换失败:积分余额不足"
        @bonus_id=params[:score_history][:point]
        @bonus_change_score= params[:score_history][:point]
        @go_url = phone_bonus_changes_url(change_score: @bonus_change_score)

      end
    when "no_login"
      @msg = "必须先授权登录"
      info = ConfigInfo["weixinconfiginfo"]
      @go_url = "#{info["AUTH_ADDR"]}appid=#{info["APPID"]}&redirect_uri=http://gzb.davco.cn/phone/mem_activations?method=wxCfgEntrance&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect"
    else
      @msg = "未知错误"
      @go_url = phone_homepages_url
    end
    
    respond_to do |format|
      format.html { redirect_to @go_url, notice: @msg }
    end

  end

  # GET /phone/score_queries/1/edit
  def edit
  end

  # POST /phone/score_queries
  # POST /phone/score_queries.json
  def create

  end

  # PATCH/PUT /phone/score_queries/1
  # PATCH/PUT /phone/score_queries/1.json
  def update
    # respond_to do |format|
    #   if @score_query.update(score_query_params)
    #     format.html { redirect_to [:phone, @score_query], notice: 'Score query was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: 'edit' }
    #     format.json { render json: @score_query.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /phone/score_queries/1
  # DELETE /phone/score_queries/1.json
  def destroy
    # @score_query.destroy
    # respond_to do |format|
    #   format.html { redirect_to phone_score_queries_url, notice: 'Score query was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_score_query
    @score_query = ScoreHistory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def score_query_params
    params[:score_query]
  end

  def score_history_params
    params.require(:score_history).permit(:point, :object_type, :object_id, :oper, :user_id, :bonus_change_id, :red_packet)
  end
  def point_total(total)
    point_sum=0
    total.each do |t|
      point_sum += t.point
    end
    return point_sum
  end
end
