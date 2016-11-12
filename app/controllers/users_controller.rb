class UsersController < ApplicationController
  before_action :authenticate_user, except: :create
  before_action :set_user, only: [:show, :update, :destroy]
  load_and_authorize_resource

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      set_uid_and_provider
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      set_uid_and_provider
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_uid_and_provider
      if auth_params[:access_token].present? && auth_params[:provider].present?
        if auth_params[:provider] == 'facebook'
          uid = FacebookService.fetch_uid(auth_params[:access_token])
          if uid.present?
            @user.uid = uid
            @user.provider = auth_params[:provider]
            @user.save
          end
        end
      end
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.fetch(:user, {}).permit(:name, :mobile, :email, :password)
    end

    def auth_params
      params.fetch(:auth, {}).permit(:access_token, :provider)
    end

end
