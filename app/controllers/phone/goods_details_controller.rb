class Phone::GoodsDetailsController < PhoneController
  layout "phone"
  before_action :set_goods_detail, only: [:show, :edit, :update, :destroy]

  # GET /phone/goods_details
  # GET /phone/goods_details.json
  def index
   
  end

  # GET /phone/goods_details/1
  # GET /phone/goods_details/1.json
  def show
  end

  # GET /phone/goods_details/new
  def new
    @goods_detail = GoodsDetail.new
  end

  # GET /phone/goods_details/1/edit
  def edit
  end

  # POST /phone/goods_details
  # POST /phone/goods_details.json
  def create
    @goods_detail = GoodsDetail.new(goods_detail_params)

    respond_to do |format|
      if @goods_detail.save
        format.html { redirect_to [:phone, @goods_detail], notice: 'Goods detail was successfully created.' }
        format.json { render action: 'show', status: :created, location: @goods_detail }
      else
        format.html { render action: 'new' }
        format.json { render json: @goods_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/goods_details/1
  # PATCH/PUT /phone/goods_details/1.json
  def update
    respond_to do |format|
      if @goods_detail.update(goods_detail_params)
        format.html { redirect_to [:phone, @goods_detail], notice: 'Goods detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @goods_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/goods_details/1
  # DELETE /phone/goods_details/1.json
  def destroy
    @goods_detail.destroy
    respond_to do |format|
      format.html { redirect_to phone_goods_details_url, notice: 'Goods detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goods_detail
      @goods_detail = GoodsDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goods_detail_params
      params[:goods_detail]
    end
end
