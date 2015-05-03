class CartsController < ApplicationController
  def show
    @cart = current_cart
    @items = @cart.items.page params[:page]
  end
end
