class Admin::RedPacketBaseRatesController < AdminController
  before_action :set_red_packet_base_rate, only: [:show, :edit, :update, :destroy]

  # GET /admin/red_packet_base_rates
  # GET /admin/red_packet_base_rates.json
  def index
    @red_packet_base_rates = RedPacketBaseRate.all
  end

  # GET /admin/red_packet_base_rates/1
  # GET /admin/red_packet_base_rates/1.json
  def show
  end

  # GET /admin/red_packet_base_rates/new
  def new
    @red_packet_base_rate = RedPacketBaseRate.new
  end

  # GET /admin/red_packet_base_rates/1/edit
  def edit
  end

  # POST /admin/red_packet_base_rates
  # POST /admin/red_packet_base_rates.json
  def create
    @red_packet_base_rate = RedPacketBaseRate.new(red_packet_base_rate_params)

    respond_to do |format|
      if @red_packet_base_rate.save
        format.html { redirect_to [:admin, @red_packet_base_rate], notice: 'Red packet base rate was successfully created.' }
        format.json { render action: 'show', status: :created, location: @red_packet_base_rate }
      else
        format.html { render action: 'new' }
        format.json { render json: @red_packet_base_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/red_packet_base_rates/1
  # PATCH/PUT /admin/red_packet_base_rates/1.json
  def update
    respond_to do |format|
      if @red_packet_base_rate.update(red_packet_base_rate_params)
        format.html { redirect_to [:admin, @red_packet_base_rate], notice: 'Red packet base rate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @red_packet_base_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/red_packet_base_rates/1
  # DELETE /admin/red_packet_base_rates/1.json
  def destroy
    @red_packet_base_rate.destroy
    respond_to do |format|
      format.html { redirect_to admin_red_packet_base_rates_url, notice: 'Red packet base rate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_red_packet_base_rate
      @red_packet_base_rate = RedPacketBaseRate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def red_packet_base_rate_params
      params.require(:red_packet_base_rate).permit(:catalog_i, :catalog_ii, :catalog_iii, :val, :rate)
    end
end
