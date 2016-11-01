class ApplicationController < ActionController::API
  include Knock::Authenticable
  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied do |exception|
    render status: 401, json: { error: 'Unauthorized'}
  end
end
