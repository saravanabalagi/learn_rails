Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  post 'user_token' => 'user_token#create'
  post '/auth/facebook/sign_up' => 'auth_facebook#get_details'
  resources :locations, :users
end
