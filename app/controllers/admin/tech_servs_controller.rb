class Admin::TechServsController < AdminController
  protect_from_forgery :except => [:update, :delete, :create]
  before_action :forbid_super_admin
  before_action :set_tech_serv, only: [:show, :edit, :update, :destroy]

  # GET /admin/tech_servs
  # GET /admin/tech_servs.json
  def index
    @tech_servs = TechServ.page(params[:page]).per(10)
  end

  # GET /admin/tech_servs/1
  # GET /admin/tech_servs/1.json
  def show
  end

  # GET /admin/tech_servs/new
  def new
    @tech_serv = TechServ.new
  end

  # GET /admin/tech_servs/1/edit
  def edit
  end

  # POST /admin/tech_servs
  # POST /admin/tech_servs.json
  def create
    @tech_serv = TechServ.new(tech_serv_params)

    respond_to do |format|
      if @tech_serv.save
        format.html { redirect_to [:admin, @tech_serv], notice: '技术服务创建成功.' }
        format.json { render action: 'show', status: :created, location: @tech_serv }
      else
        format.html { render action: 'new' }
        format.json { render json: @tech_serv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/tech_servs/1
  # PATCH/PUT /admin/tech_servs/1.json
  def update
    respond_to do |format|
       if @tech_serv.update(tech_serv_params)
        @code = 200
        @msg = "success"
        format.html { redirect_to [:admin, @tech_serv], notice: '技术服务更新成功.' }
        format.json { render json: {status: :update, code: @code, msg: @msg} }
        #format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tech_serv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/tech_servs/1
  # DELETE /admin/tech_servs/1.json
  def destroy
    @tech_serv.destroy
    respond_to do |format|
      format.html { redirect_to admin_tech_servs_url, notice: '技术服务删除成功.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tech_serv
      @tech_serv = TechServ.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tech_serv_params
      params.require(:tech_serv).permit(:content, :avatar, :title,:status)
    end
end
