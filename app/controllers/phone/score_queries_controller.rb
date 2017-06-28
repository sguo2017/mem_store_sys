class Phone::ScoreQueriesController < PhoneController
  before_action :authenticate_user!
  layout "phone" 
  before_action :set_score_query, only: [:show, :edit, :update, :destroy]

  # GET /phone/score_queries
  # GET /phone/score_queries.json
  def index
     @user = current_user   
     @score_queries = @user.score_histories.order("created_at DESC")
  end

  # GET /phone/score_queries/1
  # GET /phone/score_queries/1.json
  def show
  end

  # GET /phone/score_queries/new
  def new
    score_changed = 0 #商品是否已兑换过
    fun_type = ""   #功能类型用于是否更新商品实例
    #增加商品扫码判断
    @user = current_user 
    unless params[:fun_type].blank?
        if  params[:fun_type] == "goods_scan"
           fun_type = "goods_scan"
           #获取当前商品
           @good_instance = GoodInstance.where(:code =>params[:code]).first
           if @good_instance.status == '00A'
               good = Good.where(:id =>@good_instance.good_id).first
               @add_score = params[:score_history][:point] = good.score
               params[:score_history][:bonus_change_id] = "1"
           else
            score_changed = 1
          end
        else
        end
      else
        @add_score = -(params[:score_history][:point].presence.to_i)
     end 
    @score_query = ScoreHistory.new(score_history_params)

    respond_to do |format|
         if score_changed == 0
            if(@user.score > 0)
              #更新用户等级
              @user.changeScore(@add_score)
              # @user.save               #会员扣减积分 
              User.transaction do
                @score_query.save        #积分兑换记录
                if fun_type == "goods_scan"
                  @good_instance.status =  '00X'  #更新实例状态
                  @good_instance.save
                end
              end
              format.html { redirect_to phone_score_queries_url, notice: '积分兑换成功' }
            else
              format.html { redirect_to phone_bonus_changes_url, notice: '积分兑换失败:积分余额不足' }
            end
          else
             format.html { redirect_to phone_score_queries_url, notice: '商品积分已兑换过' }
          end
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
    respond_to do |format|
      if @score_query.update(score_query_params)
        format.html { redirect_to [:phone, @score_query], notice: 'Score query was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @score_query.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/score_queries/1
  # DELETE /phone/score_queries/1.json
  def destroy
    @score_query.destroy
    respond_to do |format|
      format.html { redirect_to phone_score_queries_url, notice: 'Score query was successfully destroyed.' }
      format.json { head :no_content }
    end
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
end
