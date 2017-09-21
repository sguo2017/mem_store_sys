class Phone::ProfilesController < PhoneController
  before_action :authenticate_user!
  layout "phone"  
  before_action :set_profile, only: [:edit, :update, :destroy]

  # GET /phone/profiles
  # GET /phone/profiles.json
  def index
     @user = current_user 
     @action = "/phone/profiles/" +  @user.id.to_s
  end

  # GET /phone/profiles/1
  # GET /phone/profiles/1.json
  def show
    unless current_user.managestores.first.users.exists?(id: params[:id])
      redirect_to main_app.root_url
    end
    @user = User.find(params[:id])
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
      @msg = ''
      detail = ""
      if profile_params["name"] != @user["name"]
        detail+="昵称 "
      end
      if profile_params["sex"] != @user["sex"]
        detail+="性别 "
      end      
      if profile_params["birthday"] != @user["birthday"]
        detail+="生日 "
      end
      if profile_params["phone_num"] != @user["phone_num"]
        detail+="电话 "
      end
      if profile_params["mem_email"] != @user["mem_email"]
        detail+="邮箱 "
      end
      if @user.update(profile_params)
        @msg = 'profile_save_success'
        effect_time = Time.now
        if detail != ""
          Wxinterface.send_template_message_profile_changed(@user,detail,effect_time)
        end
        format.html { redirect_to [:phone, "profiles"], notice:  @msg }
        #format.json { head :no_content,msg: @msg }
      else
         @msg = 'profile_save_fail'
        format.html { redirect_to [:phone, "profiles"], notice:  @msg }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
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

  #POST /phone/uploadLocation
  def uploadLocation
    @user = current_user
    @user.latitude = params["latitude"]
    @user.longitude = params["longitude"]
    @user.province = params["province"]
    @user.city = params["city"]
    @user.save
    respond_to do |format|
      #format.html { redirect_to phone_profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { render json: {
      msg: "成功！",
     }
    }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      #@profile = Profile.find(params[:id])
      @user = User.find(params[:id])
      if @user.id != current_user.id
        redirect_to phone_homepages_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      #params[:profile]
      params.require(:user).permit(:name, :sex, :birthday, :phone_num, :mem_email)
    end
end
