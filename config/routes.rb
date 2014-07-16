Rails.application.routes.draw do
  devise_for :users

  resources :products, only: [:index, :show]
  resources :carts, only: :show
  resources :orders, only: [:new, :create, :index, :show]
  resources :cart_items, only: [:create, :update, :destroy]

  root 'products#index'
end
