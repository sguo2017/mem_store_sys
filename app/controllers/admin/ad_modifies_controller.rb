class Admin::AdModifiesController < AdminController
  before_action :set_ad_modify, only: [:show, :edit, :update, :destroy]

  # GET /admin/ad_modifies
  # GET /admin/ad_modifies.json
  def index
    @ad_modifies = ConfigTableInfo.all.order("created_at DESC").page(params[:page]).per(10)
    @ad= ConfigTableInfo.where(:cf_id=>'HOME_PAGE_IMG')
    @info = '选择图片'
    @config_table_info = @ad_modifies
  end

  # GET /admin/ad_modifies/1
  # GET /admin/ad_modifies/1.json
  def show
  end

  # GET /admin/ad_modifies/new
  def new
    @ad_modify = AdModify.new
  end

  # GET /admin/ad_modifies/1/edit
  def edit
  end

  # POST /admin/ad_modifies
  # POST /admin/ad_modifies.json
  def create
    @ad_modify = AdModify.new(ad_modify_params)

    respond_to do |format|
      if @ad_modify.save
        format.html { redirect_to [:admin, @ad_modify], notice: 'Ad modify was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ad_modify }
      else
        format.html { render action: 'new' }
        format.json { render json: @ad_modify.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/ad_modifies/1
  # PATCH/PUT /admin/ad_modifies/1.json
  def update
    respond_to do |format|
      if @ad_modify.update(ad_modify_params)
        format.html { redirect_to [:admin, @ad_modify], notice: 'Ad modify was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ad_modify.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/ad_modifies/1
  # DELETE /admin/ad_modifies/1.json
  def destroy
    @ad_modify.destroy
    respond_to do |format|
      format.html { redirect_to admin_ad_modifies_url, notice: 'Ad modify was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad_modify
      @ad_modify = AdModify.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_modify_params
      params[:ad_modify]
    end
end
