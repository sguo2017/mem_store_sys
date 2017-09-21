require 'rqrcode_png'

class Admin::GoodsController < AdminController
  before_action :forbid_super_admin
  before_action :set_good, only: [:show, :edit, :update, :destroy]

  # GET /admin/goods
  # GET /admin/goods.json
  def index
      @name = params[:name]
      @goods_catalog_id = params[:goods_catalog_id]
    if @name.blank? &&  @goods_catalog_id.blank?
      @goods = Good.includes(:goods_catalog).page(params[:page]).per(10)
    else
      if @goods_catalog_id.blank? 
        @goods = Good.includes(:goods_catalog).where('name LIKE ? ', '%'+@name+'%').order("created_at DESC").page(params[:page]).per(10)
      else
        if @name.blank?   ##当name字段值为空时要去掉like,否则查询不到
           @goods = Good.includes(:goods_catalog).where(:goods_catalog_id =>@goods_catalog_id).order("created_at DESC").page(params[:page]).per(10)
        else
         @goods = Good.includes(:goods_catalog).where('name LIKE ? ', '%'+@name+'%').where(:goods_catalog_id =>@goods_catalog_id).order("created_at DESC").page(params[:page]).per(10)
        end
        
      end
    end
    @goods_catalogs = GoodsCatalog.order("created_at DESC").page(params[:page]).per(10)
  end

  # GET /admin/goods/1
  # GET /admin/goods/1.json
  def show
  end

  # GET /admin/goods/new
  def new
    @good = Good.new
    @goods_catalog = GoodsCatalog.page(params[:page])
  end

  # GET /admin/goods/1/edit
  def edit
    @goods_catalog = GoodsCatalog.page(params[:page])
  end

  # POST /admin/goods
  # POST /admin/goods.json
  def create
    @good = Good.new(good_params)

    respond_to do |format|
      if @good.save
        #生成二维码
        url = Const::GOODS_SHOW_ADDR+'/admin/goods/'+@good.id.to_s
        short_url_object = ShortUrl.new
        short_url_object.value = url
        short_url_object.save
        short_url = Const::GOODS_SHOW_ADDR + '/s/' + ShortUrl.decb64(short_url_object.id)
        p short_url
        qr = RQRCode::QRCode.new(short_url, :size => 4, :level => :h )
        png = qr.to_img                      
        png.resize(90, 90).save(Rails.root.to_s+"/public/uploads/good/qrcode/qrcode_"+@good.id.to_s+".png")
        format.html { redirect_to [:admin, @good], notice: '商品成功创建' }
        format.json { render action: 'show', status: :created, location: @good }
      else
        format.html { render action: 'new' }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/goods/1
  # PATCH/PUT /admin/goods/1.json
  def update
    respond_to do |format|
      if @good.update(good_params)
        format.html { redirect_to [:admin, @good], notice: '商品成功更新.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/goods/1
  # DELETE /admin/goods/1.json
  def destroy
    @good.destroy
    respond_to do |format|
      format.html { redirect_to admin_goods_url, notice: '商品删除成功.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_good
      @good = Good.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def good_params
      params.require(:good).permit(:code, :name, :goods_catalog_id, :scan_catalog, :scan_base_money, :spec, :status, :score, :ispromotion, :price, :avatar, :info)
    end
end
