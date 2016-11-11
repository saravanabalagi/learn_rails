class AuthFacebookController < ApplicationController

  def get_details
    if FacebookService.valid_token?(auth_params[:access_token])
      data = FacebookService.fetch_data(auth_params[:access_token])
      name = data['first_name'] + data['last_name']
      email = data['email']
      render status: :ok, json: {name: name, email: email}
    else
      render status: 403, json: {error: "Invalid token"}
    end
  end

  private

  def auth_params
    params.require(:auth).permit :access_token
  end

end