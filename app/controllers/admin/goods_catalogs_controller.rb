class Admin::GoodsCatalogsController < AdminController
  before_action :set_goods_catalog, only: [:show, :edit, :update, :destroy]

  # GET /admin/goods_catalogs
  # GET /admin/goods_catalogs.json
  def index
    @goods_catalogs = GoodsCatalog.page(params[:page]).per(10)
  end

  # GET /admin/goods_catalogs/1
  # GET /admin/goods_catalogs/1.json
  def show
  end

  # GET /admin/goods_catalogs/new
  def new
    @goods_catalog = GoodsCatalog.new
  end

  # GET /admin/goods_catalogs/1/edit
  def edit
  end

  # POST /admin/goods_catalogs
  # POST /admin/goods_catalogs.json
  def create
    @goods_catalog = GoodsCatalog.new(goods_catalog_params)

    respond_to do |format|
      if @goods_catalog.save
        format.html { redirect_to [:admin, @goods_catalog], notice: '商品分类创建成功.' }
        format.json { render action: 'show', status: :created, location: @goods_catalog }
      else
        format.html { render action: 'new' }
        format.json { render json: @goods_catalog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/goods_catalogs/1
  # PATCH/PUT /admin/goods_catalogs/1.json
  def update
    respond_to do |format|
      if @goods_catalog.update(goods_catalog_params)
        format.html { redirect_to [:admin, @goods_catalog], notice: '商品分类更新成功.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @goods_catalog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/goods_catalogs/1
  # DELETE /admin/goods_catalogs/1.json
  def destroy
    @goods_catalog.destroy
    respond_to do |format|
      format.html { redirect_to admin_goods_catalogs_url, notice: '商品分类删除成功.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goods_catalog
      @goods_catalog = GoodsCatalog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goods_catalog_params
      params.require(:goods_catalog).permit(:code, :name)
    end
end
