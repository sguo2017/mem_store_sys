class Admin::ScoreHistoriesController < AdminController
  before_action :set_score_history, only: [:show, :edit, :update, :destroy]

  # GET /admin/score_histories
  # GET /admin/score_histories.json
  def index
    @name = params[:name]
      @mem_group_id = params[:mem_group_id]
    if @name.blank? &&  @mem_group_id.blank?
      @users = User.where(:admin =>0).page(params[:page]).per(10)
    else
      if @mem_group_id.blank? 
        @users = User.where('name LIKE ? ', '%'+@name+'%').where(:admin =>0).page(params[:page]).per(10)
      else
        if @name.blank?   ##当name字段值为空时要去掉like,否则查询不到
           @users = User.where(:admin =>0).where(:mem_group_id =>@mem_group_id).page(params[:page]).per(10)
        else
         @users = User.where('name LIKE ? ', '%'+@name+'%').where(:admin =>0).where(:mem_group_id =>@mem_group_id).page(params[:page]).per(10)
        end
        
      end
    end
    @score_histories = ScoreHistory.page(params[:page]).per(10)
    @mem_groups = MemGroup.page(params[:page]).per(10)
  end

  # GET /admin/score_histories/1
  # GET /admin/score_histories/1.json
  def show
  end

  # GET /admin/score_histories/new
  def new
    @score_history = ScoreHistory.new
  end

  # GET /admin/score_histories/1/edit
  def edit
  end

  # POST /admin/score_histories
  # POST /admin/score_histories.json
  def create
    @score_history = ScoreHistory.new(score_history_params)

    respond_to do |format|
      if @score_history.save
        format.html { redirect_to [:admin, @score_history], notice: '积分历史创建成功.' }
        format.json { render action: 'show', status: :created, location: @score_history }
      else
        format.html { render action: 'new' }
        format.json { render json: @score_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/score_histories/1
  # PATCH/PUT /admin/score_histories/1.json
  def update
    respond_to do |format|
      if @score_history.update(score_history_params)
        format.html { redirect_to [:admin, @score_history], notice: '积分历史更新成功.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @score_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/score_histories/1
  # DELETE /admin/score_histories/1.json
  def destroy
    @score_history.destroy
    respond_to do |format|
      format.html { redirect_to admin_score_histories_url, notice: '积分历史删除成功.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score_history
      @score_history = ScoreHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_history_params
      params.require(:score_history).permit(:point, :object_type, :object_id, :oper, :user_id)
    end
end
