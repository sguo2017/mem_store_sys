class Phone::StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]
  layout "phone" 
  # GET /phone/stores
  # GET /phone/stores.json
  def index
    user_latitude = params[:user_latitude]
    user_longitude = params[:user_longitude]


    r = 6371.0000;    #地球半径千米  
    dis = 5.0000;   #0.5千米距离  
    dlng =  2*Math.asin(Math.sin(dis/(2*r))/Math.cos(user_latitude.to_f*3.14/180)).round(4) ;  
    # logger.debug "14 #{dlng.to_s}" 
    dlng = dlng*180/3.14.round(4);#角度转为弧度  
    dlat = dis/r.round(4);  
    dlat = dlat*180/3.14.round(4);     
    # logger.debug "17 #{dlat.to_s}"    
    # logger.debug "18 #{dlng.to_s}" 
    minlat =user_latitude.to_f - dlat;  
    maxlat = user_latitude.to_f + dlat;  
    # logger.debug "19 #{user_longitude.to_s}"
    minlng = user_longitude.to_f - dlng;  
    maxlng = user_longitude.to_f + dlng;  

    # logger.debug "21 #{maxlng.to_s}"
    # logger.debug "22 #{minlng.to_s}"

    @store  = Store.where("latitude >= ? and latitude <= ? and longitude >= ? and longitude <= ? ", minlng, maxlng, minlat, maxlat)  
    @store_array = []   
    @store.each_with_index do |store|
      s = store.attributes.clone
      if store.latitude.blank? || store.longitude.blank?
        # logger.debug "12 #{s.to_s}"
      else
        # logger.debug "14 #{s.to_s}"
        @store_array.push(s)
      end
    end  
    # logger.debug "13 #{@store_array.to_json}"
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
