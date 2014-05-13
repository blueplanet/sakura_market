class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [:update, :destroy]
  
  def create
    cart_item = CartItem.find_or_initialize_by cart: current_cart, product_id: params[:product_id]
    cart_item.quantity += 1 if cart_item.persisted?
    
    if cart_item.save
      redirect_to current_cart, notice: t('.created')
    else
      redirect_to root_path, error: cart_item.errors.full_messages.first
    end
  end

  def update
    if @cart_item.update cart_item_params
      redirect_to current_cart, notice: t('.updated')
    else
      redirect_to current_cart, error: cart_item.errors.full_messages.first
    end
  end

  def destroy
    if @cart_item.destroy
      redirect_to current_cart, notice: t('.deleted')
    else
      redirect_to root_path, error: cart_item.errors.full_messages.first
    end
  end

  private
    def set_cart_item
      @cart_item = CartItem.find params[:id]
    end

    def cart_item_params
      params.require(:cart_item).permit(:quantity)
    end
end
