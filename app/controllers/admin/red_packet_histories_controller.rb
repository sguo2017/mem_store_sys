class Admin::RedPacketHistoriesController < AdminController
  before_action :set_red_packet_history, only: [:show, :edit, :update, :destroy]

  # GET /admin/red_packet_histories
  # GET /admin/red_packet_histories.json
  def index
  	@catalog = params[:catalog]
	@start_date = params[:start_date]
	@end_date = params[:end_date]
	unless @start_date.present?
	  @start_date = Time.new(1970)
	end
	unless @end_date.present?
	  @end_date = Time.now
	end
	if @catalog.present?
	  @red_packet_histories = RedPacketHistory.where("created_at > '#{@start_date}' and created_at < '#{@end_date}' and catalog LIKE ? ", '%'+@catalog+'%').order("created_at DESC").page(params[:page]).per(10)
	else
	  @red_packet_histories = RedPacketHistory.where("created_at > '#{@start_date}' and created_at < '#{@end_date}'").order("created_at DESC").page(params[:page]).per(10)
	end
  end

  # GET /admin/red_packet_histories/1
  # GET /admin/red_packet_histories/1.json
  def show
  end

  # GET /admin/red_packet_histories/new
  def new
    @red_packet_history = RedPacketHistory.new
  end

  # GET /admin/red_packet_histories/1/edit
  def edit
  end

  # POST /admin/red_packet_histories
  # POST /admin/red_packet_histories.json
  def create
    @red_packet_history = RedPacketHistory.new(red_packet_history_params)

    respond_to do |format|
      if @red_packet_history.save
        format.html { redirect_to [:admin, @red_packet_history], notice: 'Red packet history was successfully created.' }
        format.json { render action: 'show', status: :created, location: @red_packet_history }
      else
        format.html { render action: 'new' }
        format.json { render json: @red_packet_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/red_packet_histories/1
  # PATCH/PUT /admin/red_packet_histories/1.json
  def update
    respond_to do |format|
      if @red_packet_history.update(red_packet_history_params)
        format.html { redirect_to [:admin, @red_packet_history], notice: 'Red packet history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @red_packet_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/red_packet_histories/1
  # DELETE /admin/red_packet_histories/1.json
  def destroy
    @red_packet_history.destroy
    respond_to do |format|
      format.html { redirect_to admin_red_packet_histories_url, notice: 'Red packet history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_red_packet_history
      @red_packet_history = RedPacketHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def red_packet_history_params
      params.require(:red_packet_history).permit(:user_id, :money, :catalog, :phone_number, :status)
    end
end
