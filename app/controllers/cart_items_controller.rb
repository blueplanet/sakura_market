class CartItemsController < ApplicationController
  def create
    cart_item = CartItem.new cart: current_cart, product_id: params[:product_id]
    if cart_item.save
      redirect_to current_cart, notice: t('.created')
    else
      redirect_to root_path, error: cart_item.errors.full_messages.first
    end
  end
end
