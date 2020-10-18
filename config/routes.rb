Rails.application.routes.draw do
  root to: 'root#index'
  devise_for :users
  get '/profile' => 'profile#edit', as: :profile_edit
  post '/profile' => 'profile#update', as: :profile_update
end
