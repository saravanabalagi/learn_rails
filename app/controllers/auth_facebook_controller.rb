class AuthFacebookController < ApplicationController

  def create
    if FacebookService.valid_token?(auth_params[:access_token])
      data = FacebookService.fetch_data(auth_params[:access_token])
      @user = User.find_by(uid: data['id'], provider: 'facebook')
      if @user.nil?
        name = data['first_name'] + ' ' + data['last_name']
        email = data['email']
        render status: 401, json: { error: 'Not a registered User', data: { user: { name: name, email: email }}}
      else
        render json: auth_token, status: :created
      end
    else
      render status: 401, json: { error: 'Unauthorized'}
    end
  end

  def fetch_details
    if FacebookService.valid_token?(auth_params[:access_token])
      data = FacebookService.fetch_data(auth_params[:access_token])
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

  def auth_params
    params.require(:auth).permit :access_token
  end

end