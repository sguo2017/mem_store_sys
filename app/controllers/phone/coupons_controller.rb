class Phone::CouponsController < PhoneController
  before_action :authenticate_user!
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]

  # GET /phone/coupons
  # GET /phone/coupons.json
  def index
    @user = current_user
    @coupons = Coupon.all
    @coupon_score=params[:coupon_score]
  end

  # GET /phone/coupons/1
  # GET /phone/coupons/1.json
  def show
  end

  # GET /phone/coupons/new
  def new
    @coupon = Coupon.new
  end

  # GET /phone/coupons/1/edit
  def edit
  end

  # POST /phone/coupons
  # POST /phone/coupons.json
  def create
    @coupon = Coupon.new(coupon_params)

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to [:phone, @coupon], notice: 'Coupon was successfully created.' }
        format.json { render action: 'show', status: :created, location: @coupon }
      else
        format.html { render action: 'new' }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/coupons/1
  # PATCH/PUT /phone/coupons/1.json
  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to [:phone, @coupon], notice: 'Coupon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/coupons/1
  # DELETE /phone/coupons/1.json
  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to phone_coupons_url, notice: 'Coupon was successfully destroyed.' }
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
      params.require(:coupon).permit(:name, :catalog, :good_id, :effect_time, :invalid_time, :score, :status)
    end
end
