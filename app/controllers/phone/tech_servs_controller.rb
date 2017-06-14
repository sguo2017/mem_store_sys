class Phone::TechServsController < ApplicationController
  layout "phone"
  before_action :set_tech_serv, only: [:show, :edit, :update, :destroy]

  # GET /phone/tech_servs
  # GET /phone/tech_servs.json
  def index
  end

  # GET /phone/tech_servs/1
  # GET /phone/tech_servs/1.json
  def show
  end

  # GET /phone/tech_servs/new
  def new
    @tech_serv = TechServ.new
  end

  # GET /phone/tech_servs/1/edit
  def edit
  end

  # POST /phone/tech_servs
  # POST /phone/tech_servs.json
  def create
    @tech_serv = TechServ.new(tech_serv_params)

    respond_to do |format|
      if @tech_serv.save
        format.html { redirect_to [:phone, @tech_serv], notice: 'Tech serv was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tech_serv }
      else
        format.html { render action: 'new' }
        format.json { render json: @tech_serv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/tech_servs/1
  # PATCH/PUT /phone/tech_servs/1.json
  def update
    respond_to do |format|
      if @tech_serv.update(tech_serv_params)
        format.html { redirect_to [:phone, @tech_serv], notice: 'Tech serv was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tech_serv.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/tech_servs/1
  # DELETE /phone/tech_servs/1.json
  def destroy
    @tech_serv.destroy
    respond_to do |format|
      format.html { redirect_to phone_tech_servs_url, notice: 'Tech serv was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tech_serv
      @tech_serv = TechServ.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tech_serv_params
      params[:tech_serv]
    end
end
