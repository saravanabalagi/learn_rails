class LocationChannel < ApplicationCable::Channel

  def subscribed
    stream_from 'location_user_' + current_user.id.to_s
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def search(params)
    @locations = Location.where('name ILIKE ?', params['data']+'%').limit(5)
    ActionCable.server.broadcast 'location_user_'+current_user.id.to_s,
        { locations: @locations.as_json(include: :city)}
  end

  def set_location(params)
    @location = Location.find(params['id'])
    if @location
      current_user.location = @location
      if current_user.save
        ActionCable.server.broadcast 'location_user_'+current_user.id.to_s, {
                             location: @location.as_json(include: :city),
                             user: current_user.as_json(include: :roles),
                             message: 'Successfully changed preferred location' }
      else
        ActionCable.server.broadcast 'location_user_'+current_user.id.to_s, {
                                                      error: current_user.errors,
                                                      status_code: 422 }
      end
    else ActionCable.server.broadcast 'location_user_'+current_user.id.to_s, {
                                                      error: 'Not found',
                                                      status_code: 404 }
    end
  end

end
