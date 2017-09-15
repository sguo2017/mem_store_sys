class Admin::BonusChangesController < AdminController
  before_action :forbid_super_admin
  before_action :set_bonus_change, only: [:show, :edit, :update, :destroy]

  # GET /admin/bonus_changes
  # GET /admin/bonus_changes.json
  def index
    @bonus_changes = BonusChange.page(params[:page]).per(10)
  end

  # GET /admin/bonus_changes/1
  # GET /admin/bonus_changes/1.json
  def show
  end

  # GET /admin/bonus_changes/new
  def new
    @bonus_change = BonusChange.new
  end

  # GET /admin/bonus_changes/1/edit
  def edit
  end

  # POST /admin/bonus_changes
  # POST /admin/bonus_changes.json
  def create
    @bonus_change = BonusChange.new(bonus_change_params)

    respond_to do |format|
      if @bonus_change.save
        format.html { redirect_to [:admin, @bonus_change], notice: '积分兑换红包规则成功创建.' }
        format.json { render action: 'show', status: :created, location: @bonus_change }
      else
        format.html { render action: 'new' }
        format.json { render json: @bonus_change.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/bonus_changes/1
  # PATCH/PUT /admin/bonus_changes/1.json
  def update
    respond_to do |format|
      if @bonus_change.update(bonus_change_params)
        format.html { redirect_to [:admin, @bonus_change], notice: '积分兑换红包规则成功更新.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bonus_change.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/bonus_changes/1
  # DELETE /admin/bonus_changes/1.json
  def destroy
    @bonus_change.destroy
    respond_to do |format|
      format.html { redirect_to admin_bonus_changes_url, notice: '积分兑换红包规则成功删除.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bonus_change
      @bonus_change = BonusChange.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bonus_change_params
      params.require(:bonus_change).permit(:score, :red_packet)
    end
end
