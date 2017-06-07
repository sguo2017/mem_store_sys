class Phone::HomepagesController < PhoneController
  layout "phone"

  before_action :set_homepage, only: [:show, :edit, :update, :destroy]

  # GET /phone/homepages
  # GET /phone/homepages.json
  def index
    
  end

  # GET /phone/homepages/1
  # GET /phone/homepages/1.json
  def show
  end

  # GET /phone/homepages/new
  def new
    @homepage = Homepage.new
  end

  # GET /phone/homepages/1/edit
  def edit
  end

  # POST /phone/homepages
  # POST /phone/homepages.json
  def create
    @homepage = Homepage.new(homepage_params)

    respond_to do |format|
      if @homepage.save
        format.html { redirect_to [:phone, @homepage], notice: 'Homepage was successfully created.' }
        format.json { render action: 'show', status: :created, location: @homepage }
      else
        format.html { render action: 'new' }
        format.json { render json: @homepage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/homepages/1
  # PATCH/PUT /phone/homepages/1.json
  def update
    respond_to do |format|
      if @homepage.update(homepage_params)
        format.html { redirect_to [:phone, @homepage], notice: 'Homepage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @homepage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/homepages/1
  # DELETE /phone/homepages/1.json
  def destroy
    @homepage.destroy
    respond_to do |format|
      format.html { redirect_to phone_homepages_url, notice: 'Homepage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_homepage
      @homepage = Homepage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def homepage_params
      params[:homepage]
    end
end
