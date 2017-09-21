class Admin::ConfigTableInfosController < AdminController
  before_action :forbid_store_manager
  before_action :set_config_table_info, only: [:show, :edit, :update, :destroy]

  # GET /admin/config_table_infos
  # GET /admin/config_table_infos.json
  def index
    @config_table_infos = ConfigTableInfo.all.order("created_at DESC").page(params[:page]).per(10)
  end

  # GET /admin/config_table_infos/1
  # GET /admin/config_table_infos/1.json
  def show
  end

  # GET /admin/config_table_infos/new
  def new
    @config_table_info = ConfigTableInfo.new
  end

  # GET /admin/config_table_infos/1/edit
  def edit
  end

  # POST /admin/config_table_infos
  # POST /admin/config_table_infos.json
  def create
    @config_table_info = ConfigTableInfo.new(config_table_info_params)

    respond_to do |format|
      if @config_table_info.save
        format.html { redirect_to [:admin, @config_table_info], notice: 'Config table info was successfully created.' }
        format.json { render action: 'show', status: :created, location: @config_table_info }
      else
        format.html { render action: 'new' }
        format.json { render json: @config_table_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/config_table_infos/1
  # PATCH/PUT /admin/config_table_infos/1.json
  def update
    respond_to do |format|
      if @config_table_info.update(config_table_info_params)
        format.html { redirect_to [:admin, @config_table_info], notice: 'Config table info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @config_table_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/config_table_infos/1
  # DELETE /admin/config_table_infos/1.json
  def destroy
    @config_table_info.destroy
    respond_to do |format|
      format.html { redirect_to admin_config_table_infos_url, notice: 'Config table info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_config_table_info
      @config_table_info = ConfigTableInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def config_table_info_params
      params.require(:config_table_info).permit(:cf_id, :cf_desc, :cf_value, :ad_photo)
    end
end
