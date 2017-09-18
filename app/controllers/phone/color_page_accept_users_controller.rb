class Phone::ColorPageAcceptUsersController < PhoneController
  before_action :set_color_page_accept_user, only: [:show, :edit, :update, :destroy]

  # GET /phone/color_page_accept_users
  # GET /phone/color_page_accept_users.json
  def index
    @color_page_accept_users = ColorPageAcceptUser.all
  end

  # GET /phone/color_page_accept_users/1
  # GET /phone/color_page_accept_users/1.json
  def show
  end

  # GET /phone/color_page_accept_users/new
  def new
    @color_page_accept_user = ColorPageAcceptUser.new
  end

  # GET /phone/color_page_accept_users/1/edit
  def edit
  end

  # POST /phone/color_page_accept_users
  # POST /phone/color_page_accept_users.json
  def create
    @color_page_accept_user = ColorPageAcceptUser.new(color_page_accept_user_params)

    respond_to do |format|
      if @color_page_accept_user.save
        format.html { redirect_to [:phone, @color_page_accept_user], notice: 'Color page accept user was successfully created.' }
        format.json { render action: 'show', status: :created, location: @color_page_accept_user }
      else
        format.html { render action: 'new' }
        format.json { render json: @color_page_accept_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/color_page_accept_users/1
  # PATCH/PUT /phone/color_page_accept_users/1.json
  def update
    respond_to do |format|
      if @color_page_accept_user.update(color_page_accept_user_params)
        format.html { redirect_to [:phone, @color_page_accept_user], notice: 'Color page accept user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @color_page_accept_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/color_page_accept_users/1
  # DELETE /phone/color_page_accept_users/1.json
  def destroy
    @color_page_accept_user.destroy
    respond_to do |format|
      format.html { redirect_to phone_color_page_accept_users_url, notice: 'Color page accept user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color_page_accept_user
      @color_page_accept_user = ColorPageAcceptUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def color_page_accept_user_params
      params.require(:color_page_accept_user).permit(:color_page_id, :user_id, :status)
    end
end
