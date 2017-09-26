class Admin::CouponsController < AdminController
  before_action :forbid_store_manager
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]

  # GET /admin/coupons
  # GET /admin/coupons.json
  def index
    @coupons = Coupon.all.order("created_at DESC").page(params[:page]).per(10)
  end

  # GET /admin/coupons/1
  # GET /admin/coupons/1.json
  def show
  end

  # GET /admin/coupons/new
  def new
    @coupon = Coupon.new
    @goods = Good.all.order("created_at DESC")
  end

  # GET /admin/coupons/1/edit
  def edit
  end

  # POST /admin/coupons
  # POST /admin/coupons.json
  def create
    @coupon = Coupon.new(coupon_params)

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to admin_coupons_path, notice: 'Coupon was successfully created.' }
        format.json { render action: 'show', status: :created, location: @coupon }
      else
        format.html { render action: 'new' }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/coupons/1
  # PATCH/PUT /admin/coupons/1.json
  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to [:admin, @coupon], notice: 'Coupon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/coupons/1
  # DELETE /admin/coupons/1.json
  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to admin_coupons_url, notice: 'Coupon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:name, :catalog, :effect_time, :invalid_time, :good_id, :score, :status)
    end
end
