class Admin::CouponInstancesController < AdminController
  before_action :forbid_store_manager
  before_action :set_coupon_instance, only: [:show, :edit, :update, :destroy]

  # GET /admin/coupon_instances
  # GET /admin/coupon_instances.json
  def index
    @status         = params[:status].to_s
    @created_at     = params[:created_at]
    @write_off_time = params[:write_off_time]

    _where = '1 = 1';
    if @status == '1' or @status == '0'
      @status = @status == '1' ? '已使用' : '未使用'
      _where = _where + " and status = '#{@status}'"
    end

    unless @created_at.blank?
      _where = _where + " and created_at > '#{@created_at}'"
    end

    unless @write_off_time.blank?
      _where = _where + " and write_off_time > '#{@write_off_time}'"
    end

    @coupon_instances = CouponInstance.where(_where).order("created_at DESC").page(params[:page]).per(10)
  end

  # GET /admin/coupon_instances/1
  # GET /admin/coupon_instances/1.json
  def show
  end

  # GET /admin/coupon_instances/new
  def new
    @coupon_instance = CouponInstance.new
  end

  # GET /admin/coupon_instances/1/edit
  def edit
  end

  # POST /admin/coupon_instances
  # POST /admin/coupon_instances.json
  def create
    @coupon_instance = CouponInstance.new(coupon_instance_params)

    respond_to do |format|
      if @coupon_instance.save
        format.html { redirect_to [:admin, @coupon_instance], notice: 'Coupon instance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @coupon_instance }
      else
        format.html { render action: 'new' }
        format.json { render json: @coupon_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/coupon_instances/1
  # PATCH/PUT /admin/coupon_instances/1.json
  def update
    respond_to do |format|
      if @coupon_instance.update(coupon_instance_params)
        format.html { redirect_to [:admin, @coupon_instance], notice: 'Coupon instance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @coupon_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/coupon_instances/1
  # DELETE /admin/coupon_instances/1.json
  def destroy
    @coupon_instance.destroy
    respond_to do |format|
      format.html { redirect_to admin_coupon_instances_url, notice: 'Coupon instance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #GET  /admin/coupon_instances/write_off
  def index_write_off
    render 'write_off'
  end

  # POST /admin/coupon_instances/write_off
  def write_off
    @coupon_instance = CouponInstance.where("code = ?",params[:code]).first
    if @coupon_instance.present?
      @coupon_instance.order_id = params[:order_id]
      @coupon_instance.write_off_time = Time.now
      @coupon_write_off_store_id = nil
      @coupon_instance.status = "已使用"
      @coupon_instance.save
      render json: {status: "ok",notice: "成功核销"}
    else
      render json: {status: "error",notice: "优惠券编码有误"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon_instance
      @coupon_instance = CouponInstance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_instance_params
      params.require(:coupon_instance).permit(:coupon_id, :user_id, :order_id, :status, :code, :write_off_time, :write_off_store_id)
    end
end
