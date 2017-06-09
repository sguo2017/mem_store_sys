class Phone::ScoreQueriesController < PhoneController
  layout "phone" 
  before_action :set_score_query, only: [:show, :edit, :update, :destroy]

  # GET /phone/score_queries
  # GET /phone/score_queries.json
  def index
     @user = current_user   
     @score_queries = @user.score_histories.order("created_at DESC")
  end

  # GET /phone/score_queries/1
  # GET /phone/score_queries/1.json
  def show
  end

  # GET /phone/score_queries/new
  def new
    @score_query = ScoreHistory.new(score_history_params)

    respond_to do |format|
      if @score_query.save
        #扣减积分 TODO:
        @user = current_user  
        @user.score = @user.score - params[:score_history][:point].presence.to_i
        @user.save
        #扣减积分 TODO:
        format.html { redirect_to phone_score_queries_url, notice: '积分兑换成功' }
      else
        format.html { redirect_to [:phone, @bonus_change], notice: '积分兑换失败' }
      end
    end
  end

  # GET /phone/score_queries/1/edit
  def edit
  end

  # POST /phone/score_queries
  # POST /phone/score_queries.json
  def create

  end

  # PATCH/PUT /phone/score_queries/1
  # PATCH/PUT /phone/score_queries/1.json
  def update
    respond_to do |format|
      if @score_query.update(score_query_params)
        format.html { redirect_to [:phone, @score_query], notice: 'Score query was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @score_query.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/score_queries/1
  # DELETE /phone/score_queries/1.json
  def destroy
    @score_query.destroy
    respond_to do |format|
      format.html { redirect_to phone_score_queries_url, notice: 'Score query was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score_query
      @score_query = ScoreHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_query_params
      params[:score_query]
    end

    def score_history_params
      params.require(:score_history).permit(:point, :object_type, :object_id, :oper, :user_id, :bonus_change_id, :red_packet)
    end
end
