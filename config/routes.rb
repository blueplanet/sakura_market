Rails.application.routes.draw do
  devise_for :users

  resources :products, only: [:index, :show]
  resources :carts, only: :show
  resources :orders, only: [:new, :create, :index, :show]
  resources :cart_items, only: [:create, :update, :destroy]
  resources :journals do
    resources :comments, only: [:create, :destroy]
    resources :goods, only: :create
  end

  root 'journals#index'
end
