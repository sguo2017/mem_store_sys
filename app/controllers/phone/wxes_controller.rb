class Phone::WxesController < ApplicationController
  layout "wx"
  before_action :set_wx, only: [:show, :edit, :update, :destroy]

  # GET /phone/wxes
  # GET /phone/wxes.json
  def index  
    #微信 服务器配置(已启用)  
    @echostr  = params[:echostr]
  end

  # GET /phone/wxes/1
  # GET /phone/wxes/1.json
  def show
  end

  # GET /phone/wxes/new
  def new
    @wx = Wx.new
  end

  # GET /phone/wxes/1/edit
  def edit
  end

  # POST /phone/wxes
  # POST /phone/wxes.json
  def create
    @wx = Wx.new(wx_params)

    respond_to do |format|
      if @wx.save
        format.html { redirect_to [:phone, @wx], notice: 'Wx was successfully created.' }
        format.json { render action: 'show', status: :created, location: @wx }
      else
        format.html { render action: 'new' }
        format.json { render json: @wx.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/wxes/1
  # PATCH/PUT /phone/wxes/1.json
  def update
    respond_to do |format|
      if @wx.update(wx_params)
        format.html { redirect_to [:phone, @wx], notice: 'Wx was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @wx.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/wxes/1
  # DELETE /phone/wxes/1.json
  def destroy
    @wx.destroy
    respond_to do |format|
      format.html { redirect_to phone_wxes_url, notice: 'Wx was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wx
      @wx = Wx.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wx_params
      params[:wx]
    end
end
