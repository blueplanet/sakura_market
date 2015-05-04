class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_cart
    @items = @cart.items.page params[:page]
  end
end
