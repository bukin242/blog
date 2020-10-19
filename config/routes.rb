Rails.application.routes.draw do
  root to: 'post#index'
  devise_for :users
  get '/profile' => 'profile#edit', as: :profile_edit
  post '/profile' => 'profile#update', as: :profile_update
  resources :post, as: :posts do
    resources :comment, as: :comments, only: [:create, :edit, :update, :destroy]
  end
  resources :tag, as: :tags
  get '/my' => 'post#my_posts', as: :my_posts
end
