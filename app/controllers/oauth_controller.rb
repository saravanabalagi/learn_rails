class OauthController < ApplicationController

  def create
    if oauth_params[:provider] == 'facebook'
      if FacebookService.valid_token?(oauth_params[:access_token])
        user_data = FacebookService.fetch_data(oauth_params[:access_token])
        @user = User.find_by(uid: user_data['id'], provider: 'facebook')
        if @user.nil?
          name = user_data['first_name'] + ' ' + user_data['last_name']
          email = user_data['email']
          render json: { user: { name: name, email: email }}, status: :ok
        else
          render json: { jwt: auth_token.token }, status: :created
        end
      else
        render status: :unprocessable_entity
      end
    end
  end

  def fetch_details
    if FacebookService.valid_token?(oauth_params[:access_token])
      data = FacebookService.fetch_data(oauth_params[:access_token])
      name = data['first_name'] + ' ' + data['last_name']
      email = data['email']
      render status: :ok, json: {user: { name: name, email: email }}
    else
      render status: 401, json: { error: 'Unauthorized'}
    end
  end

  private

  def auth_token
    if @user.respond_to? :to_token_payload
      Knock::AuthToken.new payload: @user.to_token_payload
    else
      Knock::AuthToken.new payload: { sub: @user.id }
    end
  end

  def oauth_params
    params.require(:oauth).permit(:access_token, :provider)
  end

end
