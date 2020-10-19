Rails.application.routes.draw do
  root to: 'post#index'
  devise_for :users
  get '/profile' => 'profile#edit', as: :profile_edit
  post '/profile' => 'profile#update', as: :profile_update
  resources :post, as: :posts
end
