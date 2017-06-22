class Phone::StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]
  layout "phone" 
  # GET /phone/stores
  # GET /phone/stores.json
  def index
    
  end

  # GET /phone/stores/1
  # GET /phone/stores/1.json
  def show
  end

  # GET /phone/stores/new
  def new
    @store = Store.new
  end

  # GET /phone/stores/1/edit
  def edit
  end

  # POST /phone/stores
  # POST /phone/stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to [:phone, @store], notice: 'Store was successfully created.' }
        format.json { render action: 'show', status: :created, location: @store }
      else
        format.html { render action: 'new' }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/stores/1
  # PATCH/PUT /phone/stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to [:phone, @store], notice: 'Store was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/stores/1
  # DELETE /phone/stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to phone_stores_url, notice: 'Store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:code, :catalog, :name, :district, :city, :province, :country, :latitude, :longitude, :addr, :linkman, :contact_num)
    end
end
