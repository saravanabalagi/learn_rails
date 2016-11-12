class FacebookService

  def self.valid_token?(access_token)
    status = false
    begin
      # We need to check if the access_token is valid for our FB APP. Source: https://developers.facebook.com/docs/facebook-login/manually-build-a-login-flow#checktoken
      debug_token = Koala::Facebook::API.new(access_token).debug_token(app_access_token_info['access_token'])
      status = true if debug_token['data']['is_valid']
    rescue => exception
        puts 'Exception thrown during facebook valid_token?: ' + exception.class.name
        puts exception
    ensure
      return status
    end
  end

  def self.fetch_data(access_token)
    Koala::Facebook::API.new(access_token).get_object('me', fields: 'name,first_name,last_name,email') if valid_token?(access_token)
  end

  def self.fetch_uid(access_token)
    if FacebookService.valid_token?(access_token)
      data = FacebookService.fetch_data(access_token)
      data['id']
    end
  end

  def self.app_access_token_info
    @app_access_token ||= Koala::Facebook::OAuth.new.get_app_access_token_info
  end

end