class Phone::GoodsController < ApplicationController
  layout "phone"
  before_action :set_good, only: [:show, :edit, :update, :destroy]

  # GET /phone/goods
  # GET /phone/goods.json
  def index
    @goods_catalog_id = params[:goods_catalog_id]
    if @goods_catalog_id.blank?
      @goods = Good.page(params[:page]).per(10)
    else
      @goods = Good.where(:goods_catalog=>@goods_catalog_id).page(params[:page]).per(10)
    end
      @goods_catalogs = GoodsCatalog.page(params[:page]).per(10)
  end

  # GET /phone/goods/1
  # GET /phone/goods/1.json
  def show
  end

  # GET /phone/goods/new
  def new
    @good = Good.new
  end

  # GET /phone/goods/1/edit
  def edit
  end

  # POST /phone/goods
  # POST /phone/goods.json
  def create
    @good = Good.new(good_params)

    respond_to do |format|
      if @good.save
        format.html { redirect_to [:phone, @good], notice: 'Good was successfully created.' }
        format.json { render action: 'show', status: :created, location: @good }
      else
        format.html { render action: 'new' }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/goods/1
  # PATCH/PUT /phone/goods/1.json
  def update
    respond_to do |format|
      if @good.update(good_params)
        format.html { redirect_to [:phone, @good], notice: 'Good was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/goods/1
  # DELETE /phone/goods/1.json
  def destroy
    @good.destroy
    respond_to do |format|
      format.html { redirect_to phone_goods_url, notice: 'Good was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_good
      @good = Good.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def good_params
      params[:good]
    end
end
