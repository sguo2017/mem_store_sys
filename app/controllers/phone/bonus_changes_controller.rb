class Phone::BonusChangesController < PhoneController
  layout "phone"
  before_action :set_bonus_change, only: [:show, :edit, :update, :destroy]

  # GET /phone/bonus_changes
  # GET /phone/bonus_changes.json
  def index
     @user = current_user   
     @bonus_changes = BonusChange.all 
  end

  # GET /phone/bonus_changes/1
  # GET /phone/bonus_changes/1.json
  def show
  end

  # GET /phone/bonus_changes/new
  def new
    @bonus_change = BonusChange.new
  end

  # GET /phone/bonus_changes/1/edit
  def edit
  end

  # POST /phone/bonus_changes
  # POST /phone/bonus_changes.json
  def create
    @bonus_change = BonusChange.new(bonus_change_params)

    respond_to do |format|
      if @bonus_change.save
        format.html { redirect_to [:phone, @bonus_change], notice: 'Bonus change was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bonus_change }
      else
        format.html { render action: 'new' }
        format.json { render json: @bonus_change.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/bonus_changes/1
  # PATCH/PUT /phone/bonus_changes/1.json
  def update
    respond_to do |format|
      if @bonus_change.update(bonus_change_params)
        format.html { redirect_to [:phone, @bonus_change], notice: 'Bonus change was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bonus_change.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/bonus_changes/1
  # DELETE /phone/bonus_changes/1.json
  def destroy
    @bonus_change.destroy
    respond_to do |format|
      format.html { redirect_to phone_bonus_changes_url, notice: 'Bonus change was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bonus_change
      @bonus_change = BonusChange.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bonus_change_params
      params[:bonus_change]
    end
end
