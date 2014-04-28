Rails.application.routes.draw do
  devise_for :users
  resources :products, only: :index
  resources :carts, only: :show

  root 'products#index'
end
