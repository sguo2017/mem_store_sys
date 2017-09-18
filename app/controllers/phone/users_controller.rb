class Phone::UsersController < PhoneController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /phone/users
  # GET /phone/users.json
  def index
    @name = params[:name]
    @page = params[:page] || 1
    @store = current_user.managestores.first
    if @name.blank?
      @users = @store.users.order("created_at DESC").page(params[:page]).per(10)
    else @name.blank?
      @users = @store.users.where("name LIKE ? ", "%#{@name}%").order("created_at DESC").page(params[:page]).per(10)
    end
  end

  # GET /phone/users/1
  # GET /phone/users/1.json
  def show
  end

  # GET /phone/users/new
  def new
    @user = User.new
  end

  # GET /phone/users/1/edit
  def edit
  end

  # POST /phone/users
  # POST /phone/users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to [:phone, @user], notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/users/1
  # PATCH/PUT /phone/users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to [:phone, @user], notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/users/1
  # DELETE /phone/users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to phone_users_url, notice: 'User was successfully destroyed.' }
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
      params.require(:user).permit(:name, :phone_num)
    end
end
