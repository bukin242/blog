Rails.application.routes.draw do
  root to: 'root#index'
  devise_for :users
end
