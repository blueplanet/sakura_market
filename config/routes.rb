Rails.application.routes.draw do
  devise_for :users
  resources :products, only: :index
  resources :carts, only: :show
  resources :cart_items, only: :create

  root 'products#index'
end
