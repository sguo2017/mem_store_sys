class Admin::MemLevelsController < AdminController
  before_action :set_mem_level, only: [:show, :edit, :update, :destroy]

  # GET /admin/mem_levels
  # GET /admin/mem_levels.json
  def index
    @mem_levels = MemLevel.page(params[:page]).per(10)
  end

  # GET /admin/mem_levels/1
  # GET /admin/mem_levels/1.json
  def show
  end

  # GET /admin/mem_levels/new
  def new
    @mem_level = MemLevel.new
  end

  # GET /admin/mem_levels/1/edit
  def edit
  end

  # POST /admin/mem_levels
  # POST /admin/mem_levels.json
  def create
    @mem_level = MemLevel.new(mem_level_params)

    respond_to do |format|
      if @mem_level.save
        format.html { redirect_to [:admin, @mem_level], notice: 'Mem level was successfully created.' }
        format.json { render action: 'show', status: :created, location: @mem_level }
      else
        format.html { render action: 'new' }
        format.json { render json: @mem_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/mem_levels/1
  # PATCH/PUT /admin/mem_levels/1.json
  def update
    respond_to do |format|
      if @mem_level.update(mem_level_params)
        format.html { redirect_to [:admin, @mem_level], notice: 'Mem level was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mem_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/mem_levels/1
  # DELETE /admin/mem_levels/1.json
  def destroy
    @mem_level.destroy
    respond_to do |format|
      format.html { redirect_to admin_mem_levels_url, notice: 'Mem level was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mem_level
      @mem_level = MemLevel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mem_level_params
      params.require(:mem_level).permit(:code, :name, :district, :score)
    end
end
