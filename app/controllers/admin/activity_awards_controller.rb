class Admin::ActivityAwardsController < AdminController
  before_action :forbid_super_admin
  before_action :set_activity_award, only: [:show, :edit, :update, :destroy]

  # GET /admin/activity_awards
  # GET /admin/activity_awards.json
  def index
    @activity_awards = ActivityAward.all
  end

  # GET /admin/activity_awards/1
  # GET /admin/activity_awards/1.json
  def show
  end

  # GET /admin/activity_awards/new
  def new
    @activity_award = ActivityAward.new
  end

  # GET /admin/activity_awards/1/edit
  def edit
  end

  # POST /admin/activity_awards
  # POST /admin/activity_awards.json
  def create
    #奖项设置
    @activity_award = ActivityAward.new(activity_award_params) 
    respond_to do |format|
      if @activity_award.save
        format.html { redirect_to admin_activities_path(show_page: Const::ACTIVITY_SHOW_PAGE[:award], activity_id: @activity_award.activity_id) }
      else

      end
    end
  end

  # PATCH/PUT /admin/activity_awards/1
  # PATCH/PUT /admin/activity_awards/1.json
  def update
    respond_to do |format|
      if @activity_award.update(activity_award_params)
        format.html { redirect_to admin_activities_path(show_page: Const::ACTIVITY_SHOW_PAGE[:award], activity_id: @activity_award.activity_id) }
      else
        
      end
    end
  end

  # DELETE /admin/activity_awards/1
  # DELETE /admin/activity_awards/1.json
  def destroy
    @activity_award.destroy
    respond_to do |format|
      format.html { redirect_to admin_activity_awards_url, notice: '奖项成功删除.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_award
      @activity_award = ActivityAward.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_award_params
      params[:activity_award].permit(:catalog, :rate, :activity_id, :index_of, :activity_award_cfg_name, :activity_award_cfg_id)
    end

end
