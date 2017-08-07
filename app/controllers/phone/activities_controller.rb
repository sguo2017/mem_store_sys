class Phone::ActivitiesController < PhoneController
  before_action :authenticate_user!
  layout "phone"
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /phone/activities
  # GET /phone/activities.json
  def index
    @activity = Activity.new
    @user = current_user 
    @restaraunts = ["100M省内流量包", "谢谢参与", "谢谢参与", "谢谢参与", "10M免费流量包", "20M免费流量包", "谢谢参与 ", "30M免费流量包", "100M免费流量包", "谢谢参与"]
    @colors = ["#FFF4D6", "#FFFFFF", "#FFF4D6", "#FFFFFF","#FFF4D6", "#FFFFFF", "#FFF4D6", "#FFFFFF","#FFF4D6", "#FFFFFF"];
 
    #活动ID
    # @activity_id = params[:activity_id]  
    # unless @activity_id.blank?
    #   @activity = Activity.find(@activity_id)
    #   @activity_awards = @activity.activity_awards.where("status='00A'")
    #   @restaraunts = []
    #   @activity_awards.each do |award|
    #     @activity_award_cfg = ActivityAwardCfg.find(award.activity_award_cfg_id)
    #     @restaraunts.push(@activity_award_cfg.name)
    #   end
    # end 

    #只有唯一有效
    @activity = Activity.where("status='00A'").first
    @activity_awards = @activity.activity_awards.where("status='00A'")
    @restaraunts = []
    @restaraunts_idx = ["一","二","三","四","五","六","七","八","九","十"]    
    @activity_awards.each_with_index do |award,index|
      @activity_award_cfg = ActivityAwardCfg.find(award.activity_award_cfg_id)
      @restaraunts.push(award.catalog+"#"+@activity_award_cfg.name)
    end

    #抽奖次数
    #has_draw = @user.lotteries.where("created_at >= ?", Time.now.beginning_of_day).size

    #@avaliable = Const::CHANCE_DRAE_COUNT.to_i - has_draw 

    #按消耗决定抽奖次数
    #@avaliable =  @user.score / Const::SCORE_COST.to_i
    $config_info.each do |c|
      if c.cf_id == "ACTIVITY_SCORE_COST"
         @cost = c.cf_value.to_i
      end
    end
  end

  # GET /phone/activities/1
  # GET /phone/activities/1.json
  def show
  end

  # GET /phone/activities/new
  def new
    @activity = Activity.new
  end

  # GET /phone/activities/1/edit
  def edit
  end

  # POST /phone/activities
  # POST /phone/activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to [:phone, @activity], notice: 'Activity was successfully created.' }
        format.json { render action: 'show', status: :created, location: @activity }
      else
        format.html { render action: 'new' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/activities/1
  # PATCH/PUT /phone/activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to [:phone, @activity], notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/activities/1
  # DELETE /phone/activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to phone_activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params[:activity]
    end
end
