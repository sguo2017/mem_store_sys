class Phone::CouponInstancesController < PhoneController
  before_action :authenticate_user!
  before_action :set_coupon_instance, only: [:show, :edit, :update, :destroy]

  # GET /phone/coupon_instances
  # GET /phone/coupon_instances.json
  def index
    @user = current_user
    @coupon_instances = @user.coupon_instances
    @c_type = params[:c_type]
    if @c_type.blank?
      @c_type = "unused"
    end
    case @c_type
    when "unused"
      @coupon_instances = @user.coupon_instances
                          .joins(:coupon)
                          .where("coupon_instances.status=? and coupons.invalid_time>?","未使用",Time.now)
                          .order("created_at DESC")
    when "used"
      @coupon_instances = @user.coupon_instances.where("status=?","已使用").order("created_at DESC")
    when "invalid"
      @coupon_instances = @user.coupon_instances
                          .joins(:coupon)
                          .where("coupon_instances.status=? and coupons.invalid_time<?","未使用",Time.now)
                          .order("created_at DESC")
    else
      redirect_to phone_homepages_path
    end
  end

  # GET /phone/coupon_instances/1
  # GET /phone/coupon_instances/1.json
  def show
    if @coupon_instance.user_id != current_user.id
      redirect_to phone_homepages_path
    end
  end

  # GET /phone/coupon_instances/new
  def new
    @coupon_instance = CouponInstance.new
  end

  # GET /phone/coupon_instances/1/edit
  def edit
  end

  # POST /phone/coupon_instances
  # POST /phone/coupon_instances.json
  def create
    @coupon_instance = CouponInstance.new(coupon_instance_params)

    respond_to do |format|
      if @coupon_instance.save
        format.html { redirect_to [:phone, @coupon_instance], notice: 'Coupon instance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @coupon_instance }
      else
        format.html { render action: 'new' }
        format.json { render json: @coupon_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/coupon_instances/1
  # PATCH/PUT /phone/coupon_instances/1.json
  def update
    respond_to do |format|
      if @coupon_instance.update(coupon_instance_params)
        format.html { redirect_to [:phone, @coupon_instance], notice: 'Coupon instance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @coupon_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/coupon_instances/1
  # DELETE /phone/coupon_instances/1.json
  def destroy
    @coupon_instance.destroy
    respond_to do |format|
      format.html { redirect_to phone_coupon_instances_url, notice: 'Coupon instance was successfully destroyed.' }
      format.json { head :no_content }
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
