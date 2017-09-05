class Admin::AdModifiesController < AdminController
  before_action :set_ad_modify, only: [:show, :edit, :update, :destroy]
  skip_load_and_authorize_resource
  before_action :null_resource_authorize
  # GET /admin/ad_modifies
  # GET /admin/ad_modifies.json
  def index
    @ad_modify = ConfigTableInfo.new
    #@ad_modify.image = params[:image]
    #all.order("created_at DESC").page(params[:page]).per(10)
  end

  # GET /admin/ad_modifies/1
  # GET /admin/ad_modifies/1.json
  def show
  end

  # GET /admin/ad_modifies/new
  def new

  end

  # GET /admin/ad_modifies/1/edit
  def edit
  end

  # POST /admin/ad_modifies
  # POST /admin/ad_modifies.json
  def create
    #先查找表里有没有ad_modify字段，有就直接修改，没有就新建
    ad_modifies_pre = "AD_MODIFY_"
    @ad_modify_image = ConfigTableInfo.where("cf_id = ?","#{ad_modifies_pre}IMAGE").first
    unless @ad_modify_image.blank?
      @ad_modify_title = ConfigTableInfo.where("cf_id = ?","#{ad_modifies_pre}TITLE").first   
      @ad_modify_url = ConfigTableInfo.where("cf_id = ?","#{ad_modifies_pre}URL").first
    else
      @ad_modify_image = ConfigTableInfo.new()
      @ad_modify_title = ConfigTableInfo.new()
      @ad_modify_url = ConfigTableInfo.new()
    end 
    

    image = params[:image]
    @ad_modify_image.cf_id = ad_modifies_pre+"IMAGE";
    @ad_modify_image.ad_photo = image;
    @ad_modify_image.cf_desc = "首页下面的广告图片"
    @ad_modify_image.save


    title = params[:title]
    @ad_modify_title.cf_id = ad_modifies_pre+"TITLE"
    @ad_modify_title.cf_value = title;
    @ad_modify_title.cf_desc = "首页下面的广告标题"
    @ad_modify_title.save


    url = params[:url]
    @ad_modify_url.cf_id = ad_modifies_pre+"URL";
    @ad_modify_url.cf_value = url;
    @ad_modify_url.cf_desc = "首页下面的广告链接"
    @ad_modify_url.save

    @go_url = phone_homepages_url(pre: ad_modifies_pre)

    respond_to do |format|
      format.html { redirect_to @go_url}
    end
  end

  # PATCH/PUT /admin/ad_modifies/1
  # PATCH/PUT /admin/ad_modifies/1.json
  def update
    respond_to do |format|
      if @ad_modify.update(ad_modify_params)
        format.html { redirect_to [:admin, @ad_modify], notice: 'Ad modify was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ad_modify.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/ad_modifies/1
  # DELETE /admin/ad_modifies/1.json
  def destroy
    @ad_modify.destroy
    respond_to do |format|
      format.html { redirect_to admin_ad_modifies_url, notice: 'Ad modify was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_ad_modify
  #     @ad_modify = AdModify.find(params[:id])
  #   end

  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def ad_modify_params
  #     params[:ad_modify]
  #   end
end
