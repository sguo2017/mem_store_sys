class Admin::ActivityAwardCfgsController < AdminController
  before_action :set_activity_award_cfg, only: [:show, :edit, :update, :destroy]

  # GET /admin/activity_award_cfgs
  # GET /admin/activity_award_cfgs.json
  def index
    @activity_award_cfgs = ActivityAwardCfg.all
  end

  # GET /admin/activity_award_cfgs/1
  # GET /admin/activity_award_cfgs/1.json
  def show
  end

  # GET /admin/activity_award_cfgs/new
  def new
    @activity_award_cfg = ActivityAwardCfg.new
  end

  # GET /admin/activity_award_cfgs/1/edit
  def edit
  end

  # POST /admin/activity_award_cfgs
  # POST /admin/activity_award_cfgs.json
  def create
    #奖项设置
    unless activity_award_cfg_params.blank?
      @activity_award_cfg = ActivityAwardCfg.new(activity_award_cfg_params) 

      respond_to do |format|
        if @activity_award_cfg.save
          @activity = Activity.new
          format.html { redirect_to admin_activities_path(show_page: Const::ACTIVITY_SHOW_PAGE[:award]) }
        else

        end
      end
    end
  end

  # PATCH/PUT /admin/activity_award_cfgs/1
  # PATCH/PUT /admin/activity_award_cfgs/1.json
  def update
    respond_to do |format|
      if @activity_award_cfg.update(activity_award_cfg_params)
        format.html { redirect_to [:admin, @activity_award_cfg], notice: 'Activity award cfg was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @activity_award_cfg.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/activity_award_cfgs/1
  # DELETE /admin/activity_award_cfgs/1.json
  def destroy
    @activity_award_cfg.destroy
    respond_to do |format|
      format.html { redirect_to admin_activity_award_cfgs_url, notice: 'Activity award cfg was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_award_cfg
      @activity_award_cfg = ActivityAwardCfg.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_award_cfg_params
      params.require(:activity_award_cfg).permit(:name, :level_I, :score, :avatar)
    end
end
