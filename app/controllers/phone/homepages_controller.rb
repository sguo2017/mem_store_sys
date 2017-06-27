class Phone::HomepagesController < PhoneController
  before_action :authenticate_user!
  layout "phone"

  before_action :set_homepage, only: [:show, :edit, :update, :destroy]

  # GET /phone/homepages
  # GET /phone/homepages.json
  def index
    @user = current_user 

    qr = RQRCode::QRCode.new(Const::STORES_SHOW_ADDR+'/phone/mem_activations?referee_id='+@user.id.to_s, :size => 8, :level => :h )
    png = qr.to_img                      
    png.resize(172, 172).save(Rails.root.to_s+"/public/uploads/user/mem_activation/user2code_"+@user.id.to_s+".png")
    if (@user.level.blank?) || (@user.level.to_i <= 1)
      @user.level = "1";
      mem_level =  MemLevel.where("level=? ", @user.level).first
      @level_up_per  =  (@user.score.to_f / mem_level.score.to_f * 100).to_i
    else
      down_level  =  @user.level.to_i - 1 
      mem_levels =  MemLevel.where("level=? or level = ?", @user.level, down_level).order("score ASC")
      curr_scope_num = mem_levels.second.score.to_i - mem_levels.first.score.to_i + 1
      curr_level_num = @user.score.to_i - mem_levels.first.score.to_i
      @level_up_per = (curr_level_num.to_f / curr_scope_num.to_f * 100).to_i
      if @level_up_per >= 100 
          @level_up_per = 100
          puts "等级溢出错误，超出100%, 查看用户积分与等级是否相符。"
      end
    end
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
