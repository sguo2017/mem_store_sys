class Admin::MemGroupsController < AdminController
  before_action :forbid_super_admin
  before_action :set_mem_group, only: [:show, :edit, :update, :destroy]

  # GET /admin/mem_groups
  # GET /admin/mem_groups.json
  def index
    @mem_groups = MemGroup.page(params[:page]).per(10)
  end

  # GET /admin/mem_groups/1
  # GET /admin/mem_groups/1.json
  def show
  end

  # GET /admin/mem_groups/new
  def new
    @mem_group = MemGroup.new
  end

  # GET /admin/mem_groups/1/edit
  def edit
  end

  # POST /admin/mem_groups
  # POST /admin/mem_groups.json
  def create
    @mem_group = MemGroup.new(mem_group_params)

    respond_to do |format|
      if @mem_group.save
        format.html { redirect_to [:admin, @mem_group], notice: '会员分组创建成功.' }
        format.json { render action: 'show', status: :created, location: @mem_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @mem_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/mem_groups/1
  # PATCH/PUT /admin/mem_groups/1.json
  def update
    respond_to do |format|
      if @mem_group.update(mem_group_params)
        format.html { redirect_to [:admin, @mem_group], notice: '会员分组信息更新成功.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mem_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/mem_groups/1
  # DELETE /admin/mem_groups/1.json
  def destroy
    @mem_group.destroy
    respond_to do |format|
      format.html { redirect_to admin_mem_groups_url, notice: '会员分组成功删除.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mem_group
      @mem_group = MemGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mem_group_params
      params.require(:mem_group).permit(:city, :province, :country)
    end
end
