class CartsController < ApplicationController
  def show
    @cart = Cart.find params[:id]
    @items = @cart.items.page params[:page]
  end
end
