class CartItemsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    cart_item = CartItem.find_or_initialize_by cart: current_cart, product_id: params[:product_id]
    cart_item.quantity += 1 if cart_item.persisted?
    
    if cart_item.save
      redirect_to current_cart, notice: t('.created')
    else
      redirect_to root_path, error: cart_item.errors.full_messages.first
    end
  end
end
