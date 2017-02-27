class OrderChannel < ApplicationCable::Channel

  def subscribed
    stream_from 'order_' + find_current_user_privileges
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  protected

  def find_current_user_privileges
    if current_user.has_role?(:restaurant_admin, :any)
      restaurant_id = current_user.roles
                          .where(name: 'restaurant_admin', resource_type: 'Restaurant')[0]
                          .resource_id
      'restaurant_' + restaurant_id.to_s
    else
      'user_' + current_user.id.to_s
    end
  end

end
