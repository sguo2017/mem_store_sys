class Phone::InvitationsController < ApplicationController
  before_action :authenticate_user!
  layout "phone"
  before_action :set_phone_invitation, only: [:show, :edit, :update, :destroy]

  # GET /phone/invitations
  # GET /phone/invitations.json
  def index
    @user = current_user
    #@phone_invitations = Phone::Invitation.all
  end

  # GET /phone/invitations/1
  # GET /phone/invitations/1.json
  def show
  end

  # GET /phone/invitations/new
  def new
    @phone_invitation = Phone::Invitation.new
  end

  # GET /phone/invitations/1/edit
  def edit
  end

  # POST /phone/invitations
  # POST /phone/invitations.json
  def create
    @phone_invitation = Phone::Invitation.new(phone_invitation_params)

    respond_to do |format|
      if @phone_invitation.save
        format.html { redirect_to @phone_invitation, notice: 'Invitation was successfully created.' }
        format.json { render :show, status: :created, location: @phone_invitation }
      else
        format.html { render :new }
        format.json { render json: @phone_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone/invitations/1
  # PATCH/PUT /phone/invitations/1.json
  def update
    respond_to do |format|
      if @phone_invitation.update(phone_invitation_params)
        format.html { redirect_to @phone_invitation, notice: 'Invitation was successfully updated.' }
        format.json { render :show, status: :ok, location: @phone_invitation }
      else
        format.html { render :edit }
        format.json { render json: @phone_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone/invitations/1
  # DELETE /phone/invitations/1.json
  def destroy
    @phone_invitation.destroy
    respond_to do |format|
      format.html { redirect_to phone_invitations_url, notice: 'Invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phone_invitation
      @phone_invitation = Phone::Invitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_invitation_params
      params.fetch(:phone_invitation, {})
    end
end
