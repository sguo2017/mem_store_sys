class Admin::StoresController < AdminController
  before_action :forbid_store_manager, except: [:index,:show]
  before_action :set_store, only: [:show, :edit, :update, :destroy]
  # GET /admin/stores
  # GET /admin/stores.json
  def index
    @name = params[:name]
    if current_user.admin == 1
      if @name.blank?
        @stores = Store.page(params[:page]).per(10)
      else
        @stores = Store.where('name LIKE ? ', '%'+@name+'%').order("created_at DESC").page(params[:page]).per(10)
      end
    else
      if @name.blank?
        @stores = current_user.managestores.page(params[:page]).per(10)
      else
        @stores = current_user.managestores.where('name LIKE ? ', '%'+@name+'%').order("created_at DESC").page(params[:page]).per(10)
      end
    end
  end

  # GET /admin/stores/1
  # GET /admin/stores/1.json
  def show
    if current_user.admin == 2
      unless current_user.managestores.exists?(id: params[:id])
        redirect_to main_app.root_url
      end
    end
    @store=Store.find(params[:id])
    if @store.qrcode.blank?
      info = ConfigInfo["weixinconfiginfo"]
      go_url = "#{info["AUTH_ADDR"]}appid=#{info["APPID"]}&redirect_uri=#{Const::STORES_SHOW_ADDR}/phone/mem_activations?store_id=#{@store.id.to_s}&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect"
      short_url_object = ShortUrl.new
      short_url_object.value = go_url
      short_url_object.save
      short_url = Const::GOODS_SHOW_ADDR + '/s/' + ShortUrl.decb64(short_url_object.id)
      p short_url
      qr = RQRCode::QRCode.new(short_url, :size => 4, :level => :h )
      png = qr.to_img
      @store.qrcode = "/uploads/store/mem_activation/qrcode_"+@store.id.to_s+".png";
      png.resize(172, 172).save(Rails.root.to_s + "/public/" + @store.qrcode)
      @store.save
    end
  end

  # GET /admin/stores/new
  def new
    @store = Store.new
  end

  # GET /admin/stores/1/edit
  def edit
  end

  # POST /admin/stores
  # POST /admin/stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to [:admin, @store], notice: 'Store was successfully created.' }
        format.json { render action: 'show', status: :created, location: @store }
      else
        format.html { render action: 'new' }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/stores/1
  # PATCH/PUT /admin/stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to [:admin, @store], notice: 'Store was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/stores/1
  # DELETE /admin/stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to admin_stores_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #Self Defined
  #POST /admin/stores/set_admin
  def setStoreAdmin
    if current_user.admin == Const::MANAGER[:supper_manager]
      @user = User.find(params[:user_id])
      @notice = @user.bindingStoreAdmin(params[:store_id])
    else
      @notice = "越权操作！"
    end
    render json:{notice: @notice}
  end

  #Self Defined
  #GET /admin/users_of_store
  def getUsers
    @name  = params[:name]
    @phone = params[:phone]

    _where = "1 = 1"
    unless @name.blank?
      _where = _where + " and name like '%#{@name}%'"
    end

    unless @phone.blank?
      _where = _where + " and phone_num like '%#{@phone}%'"
    end

    _per_num = 10
    _sum_num = User.select("id").where(_where).count
    @user = User.select("id, name, phone_num").where(_where).order('id DESC').page(params[:page]).per(_per_num)

    if @user
      render json:{
        success: true,
        message: '获取用户数据成功',
        totalPage: (_sum_num / _per_num).ceil,
        data: @user
      }
    else
      render json:{
        success: false,
        message: '获取用户数据失败'
      }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_store
    @store = Store.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def store_params
    params.require(:store).permit(:code, :catalog, :name, :district, :city, :province, :country, :latitude, :longitude, :addr, :linkman, :contact_num)
  end
end
