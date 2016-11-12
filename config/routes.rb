Rails.application.routes.draw do

  # Admin Panel
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Authentication
  post '/auth' => 'user_token#create'
  post '/auth/facebook' => 'auth_facebook#create'
  post '/auth/facebook/fetch_details' => 'auth_facebook#fetch_details'

  # Verification
  get '/auth/verify' => 'verify_user#get_otp'
  post '/auth/verify' => 'verify_user#verify_otp'

  # Resources
  resources :locations, :users

end
