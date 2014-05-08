Rails.application.routes.draw do
  devise_for :users

  resources :products, only: [:index, :show]
  resources :carts, only: :show
  resources :cart_items, only: [:create, :destroy]

  root 'products#index'
end
