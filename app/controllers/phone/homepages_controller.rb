class Phone::HomepagesController < PhoneController
  before_action :authenticate_user!
  layout "phone"

  before_action :set_homepage, only: [:show, :edit, :update, :destroy]

  # GET /phone/homepages
  # GET /phone/homepages.json
  def index
    @title="会员中心"
    @user = current_user 
    if @user.qrcode.blank?
	  info = ConfigInfo["weixinconfiginfo"]
      go_url = "#{info["AUTH_ADDR"]}appid=#{info["APPID"]}&redirect_uri=#{Const::STORES_SHOW_ADDR}/phone/mem_activations?referee_id=#{@user.id.to_s}&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect"   
      qr = RQRCode::QRCode.new(go_url, :size => 16, :level => :h )
      png = qr.to_img                      
      @user.qrcode = "uploads/user/mem_activation/user2code_"+@user.id.to_s+".png"
      png.resize(172, 172).save(Rails.root.to_s + "/public/" + @user.qrcode)
      @user.save
    end  
    #分配会员等级对应的名称和图标
 
    mem_level = MemLevel.where(" score > ? ", @user.score).order(" score ").first
    if mem_level.blank?
        mem_level = MemLevel.order(" score ").last
        @user.level = mem_level.code
        @level_name = mem_level.name
        @ico_level = "level_#{@user.level}.png"
        @user.save 
    else
        @user.level = mem_level.code
        @level_name = mem_level.name
        @ico_level = "level_#{@user.level}.png"
        @user.save       
    end

    #分配会员等级对应的名称和图标

    $config_info.each do |c|
      if c.cf_id == "HOME_PAGE_IMG"
       @photo = c.ad_photo
      end
    end

    #计算会员升级的百分比<<
    @level_up_per = 0
    if @user.score > 0
      @mem_levels = MemLevel.all.order("score ASC")
      @mem_levels.each_with_index do |l,index|
        if @user.level < l.code          
          next_level = @mem_levels[index-1]
          @level_up_per = (@user.score.to_f / next_level.score.to_f * 100).to_i
          break
        else 
          @level_up_per = 100
        end 
      end

      if @level_up_per>99
        @level_up_per = 100
      end
    else
      @level_up_per = 0   
    end

    #计算会员升级的百分比<<  
    pre = params[:pre]
    title = ConfigTableInfo.where("cf_id = ?", "AD_MODIFY_title").first
    @title = title.cf_value
    url = ConfigTableInfo.where("cf_id = ?", "AD_MODIFY_url").first 
    @url = url.cf_value
    @image = ConfigTableInfo.where("cf_id = ?", "AD_MODIFY_image").first 
  end

  # GET /phone/homepages/1
  # GET /phone/homepages/1.json
  def show
  end

  # GET /phone/homepages/new
  def new
    @homepage = Homepage.new
  end

  # GET /phone/homepages/1/edit
  def edit
  end

  # POST /phone/homepages
  # POST /phone/homepages.json
  def create
    @homepage = Homepage.new(homepage_params)

    respond_to do |format|
      if @homepage.save
        format.html { redirect_to [:phone, @homepage], notice: 'Homepage was successfully created.' }
        format.json { render action: 'show', status: :created, location: @homepage }
      else
        format.html { render action: 'new' }
        format.json { render json: @homepage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/homepages/1
  # PATCH/PUT /phone/homepages/1.json
  def update
    respond_to do |format|
      if @homepage.update(homepage_params)
        format.html { redirect_to [:phone, @homepage], notice: 'Homepage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @homepage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/homepages/1
  # DELETE /phone/homepages/1.json
  def destroy
    @homepage.destroy
    respond_to do |format|
      format.html { redirect_to phone_homepages_url, notice: 'Homepage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_homepage
      @homepage = Homepage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def homepage_params
      params[:homepage]
    end
end
