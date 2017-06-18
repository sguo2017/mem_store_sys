class Phone::ProfilesController < PhoneController
  before_action :authenticate_user!
  layout "phone"  
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /phone/profiles
  # GET /phone/profiles.json
  def index
     @user = current_user    
  end

  # GET /phone/profiles/1
  # GET /phone/profiles/1.json
  def show
  end

  # GET /phone/profiles/new
  def new
    @profile = Profile.new
  end

  # GET /phone/profiles/1/edit
  def edit
  end

  # POST /phone/profiles
  # POST /phone/profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to [:phone, @profile], notice: 'Profile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/profiles/1
  # PATCH/PUT /phone/profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to [:phone, @profile], notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/profiles/1
  # DELETE /phone/profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to phone_profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params[:profile]
    end
end
