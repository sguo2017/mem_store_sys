class Phone::ActivitiesController < ApplicationController
  layout "phone"
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /phone/activities
  # GET /phone/activities.json
  def index

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
