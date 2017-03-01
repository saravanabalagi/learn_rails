class ApplicationController < ActionController::API
  include Knock::Authenticable
  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied do |exception|
    render status: 401, json: { error: 'Unauthorized'}
  end

  protected

  def set_pagination_header(name, options = {})
    scope = instance_variable_get("@#{name}")
    headers['Pagination-Total-Pages'] = scope.total_pages
    headers['Pagination-Total-Count'] = scope.total_count
    headers['Pagination-Next-Page-Available'] = !scope.last_page?
  end


end
