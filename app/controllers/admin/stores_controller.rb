class Admin::StoresController < AdminController
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  # GET /admin/stores
  # GET /admin/stores.json
  def index
    @name = params[:name]
    if @name.blank? 
      @stores = Store.page(params[:page]).per(10)
    else
      @stores = Store.where('name LIKE ? ', '%'+@name+'%').order("created_at DESC").page(params[:page]).per(10)
    end
  end

  # GET /admin/stores/1
  # GET /admin/stores/1.json
  def show 
    @store=Store.find(params[:id])
    if @store.qrcode.blank?
      go_url = "#{Const::WXConfig::AUTH_ADDR}appid=#{Const::WXConfig::APPID}&redirect_uri=#{Const::STORES_SHOW_ADDR}/phone/mem_activations?store_id=#{@store.id.to_s}&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect"   
      logger.debug "21  #{go_url}"
      qr = RQRCode::QRCode.new(go_url, :size => 16, :level => :h )
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
