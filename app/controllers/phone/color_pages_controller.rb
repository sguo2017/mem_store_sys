class Phone::ColorPagesController < ApplicationController
  before_action :authenticate_user!
  layout "phone"
  before_action :set_color_page, only: [:show, :edit, :update, :destroy]

  # GET /phone/color_pages
  # GET /phone/color_pages.json
  def index
    @name = params[:name]
    @page = params[:page] || 1
    userId = current_user.id

    if @name.blank?
      @color_pages = ColorPage.where("user_id = ? ", userId).order("created_at DESC").page(params[:page]).per(10)
    else @name.blank?
      @color_pages = ColorPage.where("user_id = ? and name LIKE ? ", userId, "%#{@name}%").order("created_at DESC").page(params[:page]).per(10)
    end
  end

  # GET /phone/color_pages/1
  # GET /phone/color_pages/1.json
  def show
  end

  # GET /phone/color_pages/new
  def new
    @color_page = ColorPage.new
  end

  # GET /phone/color_pages/1/edit
  def edit
  end

  # POST /phone/color_pages
  # POST /phone/color_pages.json
  def create
    @color_page = ColorPage.new(color_page_params)
    @color_page.user_id = current_user.id

    respond_to do |format|
      if @color_page.save
        if @color_page.accept_users_type == 1
          @users = current_user.managestores.first.users
          active_url = Const::DOMAIN + phone_color_page_path(@color_page)
          @users.each do |u|
            Wxinterface.send_template_message_active_notice(u,active_url,@color_page.name,@color_page.time,@color_page.address)
          end
        end
        format.html { redirect_to [:phone, @color_page], notice: 'Color page was successfully created.' }
        format.json { render action: 'show', status: :created, location: @color_page }
      else
        format.html { render action: 'new' }
        format.json { render json: @color_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/color_pages/1
  # PATCH/PUT /phone/color_pages/1.json
  def update
    respond_to do |format|
      if @color_page.update(color_page_params)
        format.html { redirect_to [:phone, @color_page], notice: 'Color page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @color_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/color_pages/1
  # DELETE /phone/color_pages/1.json
  def destroy
    @color_page.destroy
    respond_to do |format|
      format.html { redirect_to phone_color_pages_url, notice: 'Color page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color_page
      @color_page = ColorPage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def color_page_params
      params.require(:color_page).permit(:name, :time, :address, :profile, :avatar, :content, :accept_users_type, :user_id)
    end
end
