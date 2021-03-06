Rails.application.routes.draw do
  resources :products, only: [:index, :show]

  resource :cart, only: :show
  resources :orders, only: [:new, :create, :index, :show]
  resources :cart_items, only: [:create, :update, :destroy]
  resource :default_address, only: [:edit, :update]

  resources :journals do
    resources :comments, only: [:create, :destroy]
    resources :goods, only: :create
  end

  resources :profiles, only: :show
  resource :profile, only: [:edit, :update]

  root 'journals#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
end
