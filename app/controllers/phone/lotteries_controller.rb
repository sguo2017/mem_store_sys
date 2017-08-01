class Phone::LotteriesController < PhoneController
  before_action :authenticate_user!
  before_action :set_lottery, only: [:show, :edit, :update, :destroy]

  # GET /phone/lotteries
  # GET /phone/lotteries.json
  def index
    @lotteries = Lottery.all   
  end

  # GET /phone/lotteries/1
  # GET /phone/lotteries/1.json
  def show
  end

  # GET /phone/lotteries/new
  def new
    @lottery = Lottery.new

  end

  # GET /phone/lotteries/1/edit
  def edit
  end

  # POST /phone/lotteries
  # POST /phone/lotteries.json
  def create    
    @user = current_user 
    #抽奖次数
    #has_draw = @user.lotteries.where("created_at >= ?", Time.now.beginning_of_day).size
    #@avaliable = Const::CHANCE_DRAE_COUNT.to_i - has_draw 
    #按消耗决定抽奖次数
    @avaliable =  @user.score / Const::SCORE_COST.to_i
    if @avaliable < 1 
      return render json: {status: "-1", msg: Const::LOTTERY_MSG[:score_not_enough] }
    end

    @activity = Activity.new
    @lottery = Lottery.new(lottery_params)
    #中奖奖项
    @item = -1
    #
    @activity_id = params[:lottery][:activity_id]  
    unless @activity_id.blank?
      @activity = Activity.find(@activity_id)
      @lottery.activity_id = @activity.id
      @lottery.activity_name = @activity.title
    end
    #中奖算法

    pdf = [] 
    @activity_awards = @activity.activity_awards.where("status='00A'").order("index_of ASC")
    #logger.debug "50 #{@activity_awards.to_json}"
    @activity_awards.each do |award|        
      rate = award.rate.to_f
      pdf.push(rate/100.00)
    end

    logger.debug "#{pdf.to_s}"
    cdf = pdf2cdf(pdf);
    logger.debug "#{cdf.to_s}"

    @item = discreteSampling(cdf)  

    
    @lottery.activity_award_id = @activity_awards[@item.to_i-1].id
    @activity_award_cfg = ActivityAwardCfg.find(@activity_awards[@item.to_i-1].activity_award_cfg_id)
    @lottery.activity_award_cfg_id = @activity_award_cfg.id
    @lottery.activity_award_cfg_name = @activity_award_cfg.name

    if @activity_award_cfg.score == 0
      @lottery.winning = "false"
    else
      @lottery.winning = "true"
    end

    respond_to do |format|
      if @lottery.save
        @user.changeScore(-Const::SCORE_COST.to_i)
        if @activity_award_cfg.level_I == 'money'
          money = @activity_award_cfg.score*100 #单位由元转为分
          @data = @user.lotteryredpacket(money)
          @redpackethistory = RedPacketHistory.new()
          @redpackethistory.user_id = @user.id
          @redpackethistory.catalog = "抽奖活动得红包"
          @redpackethistory.phone_number = @user.phone_num
          @redpackethistory.money = money
          status = @data.scan(/\<return_msg\>\<\!\[CDATA\[(.*)\]\]\>\<\/return_msg\>/).first.first
          @redpackethistory.return_msg = status
          if status == "发放成功"
            status = "00A"
          else
            status = "00X"
          end
          @redpackethistory.status = status
          @redpackethistory.save
        else
          @user.changeScore(@activity_award_cfg.score)
          # logger.debug "86: @activity_award_cfg.score #{@activity_award_cfg.score} result:#{@activity_award_cfg.score.to_i > 0 }" 
          if @activity_award_cfg.score.to_i > 0   
            @score_query = ScoreHistory.new()
            @score_query.point = @activity_award_cfg.score 
            @score_query.object_type = "抽奖活动" 
            @score_query.object_id = @lottery.id 
            @score_query.oper = "获得" 
            @score_query.user_id = @user.id
            # @score_query.bonus_change_id = "1"
            @score_query.save
          end
        end
        format.json { 
          render json: {status: "0", item: @item, avaliable:@avaliable-1, score: @activity_award_cfg.score} 
        }
      else
        format.json { 
          render json: {status: "-2", msg: Const::LOTTERY_MSG[:unknown]} 
        }
      end
    end
  end

  # PATCH/PUT /phone/lotteries/1
  # PATCH/PUT /phone/lotteries/1.json
  def update
    respond_to do |format|
      if @lottery.update(lottery_params)
        format.html { redirect_to [:phone, @lottery], notice: 'Lottery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lottery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/lotteries/1
  # DELETE /phone/lotteries/1.json
  def destroy
    @lottery.destroy
    respond_to do |format|
      format.html { redirect_to phone_lotteries_url, notice: 'Lottery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    #离散概率算法
    def pdf2cdf(pdf)
      cdf = pdf;
      cdf.each_with_index do |item, index|
        unless index == 0 
          cdf[index] += cdf[index-1]
        end        
      end

      #Force set last cdf to 1, preventing floating-point summing error in the loop.
      cdf[cdf.size - 1] = 1.00;

      return cdf;

    end

    #根据概率出序列
    def discreteSampling(cdf)
      item = -1

      y = rand(100)/100.to_f;

      logger.debug "您中奖概率#{y.to_s}"

      cdf.each_with_index do |p, i|
        #logger.debug "i #{i.to_s} y  #{y.to_s} p #{p.to_s} y < p.to_f #{y < p.to_f}"
        if y < p.to_f
          item = i+1
          break
        end
      end
      logger.debug "您中了#{item.to_s}等奖"
      return item # should never runs here, assuming last element in cdf is 1
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_lottery
      @lottery = Lottery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lottery_params
      params.require(:lottery).permit(:activity_id, :activity_name, :winning, :activity_award_id, :activity_award_cfg_id, :activity_award_cfg_name, :user_id)
    end
end
