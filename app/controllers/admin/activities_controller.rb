class Admin::ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /admin/activities
  # GET /admin/activities.json
  def index
    @show_page = Const::ACTIVITY_SHOW_PAGE[:base] 
    unless params[:show_page].blank?
        @show_page = params[:show_page]   
    end   

    @activity = Activity.new
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
    @activity_award_cfg = ActivityAwardCfg.new(activity_award_cfg_params) 



    respond_to do |format|
      if @activity_award_cfg.save
        @activity = Activity.new
        format.html { redirect_to admin_activities_path(show_page: Const::ACTIVITY_SHOW_PAGE[:award]) }
      else

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
    def activity_award_cfg_params
      params.require(:activity_award_cfg).permit(:name, :level_I, :score)
    end
end
