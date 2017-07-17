class Admin::QrCodeScanHistoriesController < AdminController
  before_action :set_qr_code_scan_history, only: [:show, :edit, :update, :destroy]

  # GET /admin/qr_code_scan_histories
  # GET /admin/qr_code_scan_histories.json
  def index
	@count = params[:count]
	@start_date = params[:start_date]
	@end_date = params[:end_date]
	sql = "select id from qr_code_scan_histories where "
	if @start_date.present?
	  sql = sql + " created_at > '#{@start_date}' and "
	end
	if @end_date.present?
	  sql = sql + " created_at < '#{@end_date}' and "
	end
	sql = sql + "user_id in(select user_id from qr_code_scan_histories where status='00A' "
	if @start_date.present?
	  sql = sql + " and created_at > '#{@start_date}' "
	end
	if @end_date.present?
	  sql = sql + " and created_at < '#{@end_date}' "
	end
	if @count.present?
	  sql = sql + " group by user_id having count(1)>=#{@count}"
	end
	sql = sql +")"
    @qr_code_scan_histories = QrCodeScanHistory.find_by_sql(sql)
	ids = @qr_code_scan_histories.map{|q| q.id}
	@qr_code_scan_histories = QrCodeScanHistory.where(:id => ids).order("created_at DESC").page(params[:page]).per(10)
  end

  # GET /admin/qr_code_scan_histories/1
  # GET /admin/qr_code_scan_histories/1.json
  def show
  end

  # GET /admin/qr_code_scan_histories/new
  def new
    @qr_code_scan_history = QrCodeScanHistory.new
  end

  # GET /admin/qr_code_scan_histories/1/edit
  def edit
  end

  # POST /admin/qr_code_scan_histories
  # POST /admin/qr_code_scan_histories.json
  def create
    @qr_code_scan_history = QrCodeScanHistory.new(qr_code_scan_history_params)

    respond_to do |format|
      if @qr_code_scan_history.save
        format.html { redirect_to [:admin, @qr_code_scan_history], notice: 'Qr code scan history was successfully created.' }
        format.json { render action: 'show', status: :created, location: @qr_code_scan_history }
      else
        format.html { render action: 'new' }
        format.json { render json: @qr_code_scan_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/qr_code_scan_histories/1
  # PATCH/PUT /admin/qr_code_scan_histories/1.json
  def update
    respond_to do |format|
      if @qr_code_scan_history.update(qr_code_scan_history_params)
        format.html { redirect_to [:admin, @qr_code_scan_history], notice: 'Qr code scan history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @qr_code_scan_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/qr_code_scan_histories/1
  # DELETE /admin/qr_code_scan_histories/1.json
  def destroy
    @qr_code_scan_history.destroy
    respond_to do |format|
      format.html { redirect_to admin_qr_code_scan_histories_url, notice: 'Qr code scan history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qr_code_scan_history
      @qr_code_scan_history = QrCodeScanHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qr_code_scan_history_params
      params.require(:qr_code_scan_history).permit(:user_id, :good_id, :good_instance_id, :score, :status)
    end
end
