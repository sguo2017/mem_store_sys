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
    #计算会员升级的百分比<<
    if @user.level.blank?
      @user.level = "V1"
      @user.save
    end

    #计算会员升级的百分比<<
    if @user.score > 0
      @mem_levels = MemLevel.all.order("score ASC")
      @mem_levels.each_with_index do |l,index|
        if @user.level < l.code          
          next_level = @mem_levels[index-1]
          logger.debug "28 @user.score #{@user.score} next_level.score #{next_level.score} rate #{@user.score.to_f / next_level.score.to_f}"
          @level_up_per = (@user.score.to_f / next_level.score.to_f * 100).to_i
          break 
        end
      end

      if @level_up_per>99
        @level_up_per = 100
      end
    else
      @level_up_per = 0   
    end

    #计算会员升级的百分比<<  
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
