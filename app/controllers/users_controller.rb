class UsersController < ApplicationController
  before_action :authenticate_user, except: :create
  before_action :set_me, only: [:me, :update]
  # before_action :set_user, only: [:show]
  load_and_authorize_resource

  # GET /users/me
  def me
    render json: @me
  end

  # POST /users/me/location
  def set_location
    @location = Location.find(location_params[id])
    @me = current_user
    @me.location = @location
    if @me.save
      render json: @location, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # GET /users/1
  # def show
  #   render json: @user, only: [:name]
  # end

  # POST /users/create
  def create
    @user = User.new(user_params)
    if @user.save
      set_uid_and_provider
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/me
  def update
    if @user.update(user_params)
      set_uid_and_provider
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_me
      @me = current_user
    end

    def set_uid_and_provider
      if oauth_params[:access_token].present? && oauth_params[:provider].present?
        if oauth_params[:provider] == 'facebook'
          uid = FacebookService.fetch_uid(oauth_params[:access_token])
          if uid.present?
            @user.uid = uid
            @user.provider = oauth_params[:provider]
            @user.save
          end
        end
      end
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.fetch(:user, {}).permit(:name, :mobile, :email, :password)
    end

    def oauth_params
      params.fetch(:oauth, {}).permit(:access_token, :provider)
    end

    def location_params
      params.fetch(:location, {}).permit(:id)
    end

end
