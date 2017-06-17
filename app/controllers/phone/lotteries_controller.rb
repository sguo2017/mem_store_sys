class Phone::LotteriesController < ApplicationController
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
    has_draw = @user.lotteries.where("created_at >= ?", Time.now.beginning_of_day).size
    @avaliable = Const::CHANCE_DRAE_COUNT.to_i - has_draw 
    if @avaliable < 1 
      return render json: {status: "-1", msg: Const::LOTTERY_MSG[:no_chance] }
    end

    @activity = Activity.new
    @lottery = Lottery.new(lottery_params)
    #中奖名次
    @item = -1
    #
    @activity_id = params[:activity_id]  
    unless @activity_id.blank?
      @activity = Activity.find(@activity_id)
    end
    #中奖算法

    @item = rand(@activity.award_count)   

    respond_to do |format|
      if @lottery.save
        format.json { 
          render json: {status: "0", item: @item} 
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
    # Use callbacks to share common setup or constraints between actions.
    def set_lottery
      @lottery = Lottery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lottery_params
      params.require(:lottery).permit(:activity_id, :activity_name, :winning, :activity_award_id, :activity_award_cfg_id, :activity_award_cfg_name, :user_id)
    end
end
