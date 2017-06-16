class Admin::ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /admin/activities
  # GET /admin/activities.json
  def index
    @activity = Activity.new
    @activity_award = ActivityAward.new
    @activity_award_cfg = ActivityAwardCfg.new
    @all_level_I = [["积分奖品1", "积分奖品1"], ["积分奖品2", "积分奖品2"], ["积分奖品3", "积分奖品3"]]   

    #活动ID
    @activity_id = params[:activity_id]  
    unless @activity_id.blank?
      @activity = Activity.find(@activity_id)
    end

    #活动奖项数量
    @award_count = 6 
    unless params[:award_count] .blank?
       @award_count = params[:award_count] 
    end
    unless @activity.id.blank?
      @activity.award_count = @award_count
      @activity.save
      #改变多设置的奖项状态
      $i = 1        
      while $i <  6 do
        if $i > @award_count.to_i
          award = ActivityAward.where("index_of=? and activity_id=?", $i-1, @activity_id).first
          unless award.blank?
            award.status = '00X'
            award.save;            
          end
        else
          award = ActivityAward.where("index_of=? and activity_id=?", $i, @activity_id).first
          unless award.blank?
            award.status = '00A'
            award.save;            
          end
        end

        $i +=1
      end

    end 

    #@activity_awards = @activity.activity_awards

    #奖项设置显示index
    @show_activity_award_id = 0
    unless params[:show_activity_award_id].blank?
      @show_activity_award_id = params[:show_activity_award_id] 
    end 

    if @show_activity_award_id.to_i > @award_count.to_i
      @show_activity_award_id = 0
    end

    #加载奖项
    begin
      @activity_award = ActivityAward.where("index_of=? and activity_id=?", @show_activity_award_id, @activity_id).first
    rescue ActiveRecord::RecordNotFound => e
      @activity_award = ActivityAward.new
    end

    if @activity_award.blank?
      @activity_award = ActivityAward.new
    end


    #奖项配置ID
    @activity_award_cfg_id = params[:activity_award_cfg_id]  
    unless @activity_award_cfg_id.blank?
      @activity_award_cfg = ActivityAwardCfg.find(@activity_award_cfg_id)      
    end

    #显示tab页
    @show_page = Const::ACTIVITY_SHOW_PAGE[:base] 
    unless params[:show_page].blank?
      @show_page = params[:show_page]  
      case @show_page
        when Const::ACTIVITY_SHOW_PAGE[:base] 
          
        when Const::ACTIVITY_SHOW_PAGE[:award] 

        when Const::ACTIVITY_SHOW_PAGE[:cfg] 

        end  
    end   
    

  end

  # GET /admin/activities/1
  # GET /admin/activities/1.json
  def show

  end

  # GET /admin/activities/new
  def new
    @activity_award = ActivityAward.new
  end

  # GET /admin/activities/1/edit
  def edit

  end

  # POST /admin/activities
  # POST /admin/activities.json
  def create
    #基础设置
    unless activity_params.blank?
      @activity = Activity.new(activity_params) 

      respond_to do |format|
        if @activity.save
          format.html { redirect_to admin_activities_path(show_page: Const::ACTIVITY_SHOW_PAGE[:base], activity_id:@activity.id) }
        else

        end
      end
    end
  end

  # PATCH/PUT /admin/activities/1
  # PATCH/PUT /admin/activities/1.json
  def update


  end

  # DELETE /admin/activities/1
  # DELETE /admin/activities/1.json
  def destroy


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
      @activity_award = ActivityAward.find(params[:id])
      @activity_award_cfg = ActivityAwardCfg.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.

    def activity_params
      params.require(:activity).permit(:title, :begin_time, :end_time, :desc, :avatar, :award_count)
    end    
end
