class Phone::CitySelectionsController < PhoneController
  layout "phone"
  before_action :set_city_selection, only: [:show, :edit, :update, :destroy]

  # GET /phone/city_selections
  # GET /phone/city_selections.json
  def index
  end

  # GET /phone/city_selections/1
  # GET /phone/city_selections/1.json
  def show
  end

  # GET /phone/city_selections/new
  def new
    @city_selection = CitySelection.new
  end

  # GET /phone/city_selections/1/edit
  def edit
  end

  # POST /phone/city_selections
  # POST /phone/city_selections.json
  def create
    @city_selection = CitySelection.new(city_selection_params)

    respond_to do |format|
      if @city_selection.save
        format.html { redirect_to [:phone, @city_selection], notice: 'City selection was successfully created.' }
        format.json { render action: 'show', status: :created, location: @city_selection }
      else
        format.html { render action: 'new' }
        format.json { render json: @city_selection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/city_selections/1
  # PATCH/PUT /phone/city_selections/1.json
  def update
    respond_to do |format|
      if @city_selection.update(city_selection_params)
        format.html { redirect_to [:phone, @city_selection], notice: 'City selection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @city_selection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/city_selections/1
  # DELETE /phone/city_selections/1.json
  def destroy
    @city_selection.destroy
    respond_to do |format|
      format.html { redirect_to phone_city_selections_url, notice: 'City selection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city_selection
      @city_selection = CitySelection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_selection_params
      params[:city_selection]
    end
end
