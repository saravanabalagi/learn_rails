class UsersController < ApplicationController
  before_action :authenticate_user, except: :create
  before_action :set_me, only: [:me, :update]
  # before_action :set_user, only: [:show]
  load_and_authorize_resource

  # GET /users/me
  def me
    render json: @me, include: :roles
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
    set_uid_and_provider
    if @user.save
      render status: :created, json: @user, include: :roles
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/me
  def update
    set_uid_and_provider
    if @user.update(user_params)
      render json: @user, include: :roles
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
          if FacebookService.valid_token? oauth_params[:access_token]
            user_data = FacebookService.fetch_data oauth_params[:access_token]
            @user.provider = oauth_params[:provider]
            @user.uid = user_data['id']
            @uesr.name = user_data['first_name'] + ' ' + user_data['last_name']
            @uesr.email = user_data['email'] unless user_data['email'].nil?
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
