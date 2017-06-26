class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  # GET /admin/users.json
  def index
      @name = params[:name]
      @mem_group_id = params[:mem_group_id]
    if @name.blank? &&  @mem_group_id.blank?
      @users = User.where(:admin =>0).where("status <> '00H'").page(params[:page]).per(10)
    else
      if @mem_group_id.blank? 
        @users = User.where('name LIKE ? ', '%'+@name+'%').where(:admin =>0).where("status <> '00H'").page(params[:page]).per(10)
      else
        if @name.blank?   ##当name字段值为空时要去掉like,否则查询不到
           @users = User.where(:admin =>0).where("status <> '00H'").where(:mem_group_id =>@mem_group_id).page(params[:page]).per(10)
        else
         @users = User.where('name LIKE ? ', '%'+@name+'%').where(:admin =>0).where("status <> '00H'").where(:mem_group_id =>@mem_group_id).page(params[:page]).per(10)
        end
        
      end
    end
    @mem_groups = MemGroup.page(params[:page]).per(10)
    
    
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to [:admin, @user], notice: '会员添加成功.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_url, notice: '会员信息已成功更新.' }
        @code = 200
        @msg = "success"
        format.json { render json: {status: :update, code: @code, msg: @msg} }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: '会员已成功删除.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      #params.require(:user).permit(:mem_group_id,:status,:name)
      params.require(:user).permit(:email, :level, :admin, :score, :name, :code, :sex, :birthday, :phone_num, :score_total, :mem_group_id, :district, :city, :province, :country, :latitude, :longitude, :referee_id, :store_id, :status, :mem_email)
      #params[:user]
    end
end
