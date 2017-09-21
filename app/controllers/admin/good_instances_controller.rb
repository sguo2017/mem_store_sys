class Admin::GoodInstancesController < AdminController
  before_action :forbid_store_manager
  before_action :set_good_instance, only: [:show, :edit, :update, :destroy]

  # GET /admin/good_instances
  # GET /admin/good_instances.json
  def index
    @good_instances = GoodInstance.page(params[:page]).per(10)
  end

  # GET /admin/good_instances/1
  # GET /admin/good_instances/1.json
  def show
  end

  # GET /admin/good_instances/new
  def new
    @good_instance = GoodInstance.new
  end

  # GET /admin/good_instances/1/edit
  def edit
  end

  # POST /admin/good_instances
  # POST /admin/good_instances.json
  def create
    @good_instance = GoodInstance.new(good_instance_params)

    respond_to do |format|
      if @good_instance.save
        format.html { redirect_to [:admin, @good_instance], notice: 'Good instance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @good_instance }
      else
        format.html { render action: 'new' }
        format.json { render json: @good_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/good_instances/1
  # PATCH/PUT /admin/good_instances/1.json
  def update
    respond_to do |format|
      if @good_instance.update(good_instance_params)
        format.html { redirect_to [:admin, @good_instance], notice: 'Good instance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @good_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/good_instances/1
  # DELETE /admin/good_instances/1.json
  def destroy
    @good_instance.destroy
    respond_to do |format|
      format.html { redirect_to admin_good_instances_url, notice: 'Good instance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_good_instance
      @good_instance = GoodInstance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def good_instance_params
      params.require(:good_instance).permit(:code, :good_id, :status)
    end
end
