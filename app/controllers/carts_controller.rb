class CartsController < ApplicationController
  def show
    @cart = Cart.find params[:id]
    @items = @cart.cart_items.page params[:page]
  end
end
