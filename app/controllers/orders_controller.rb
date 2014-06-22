class OrdersController < ApplicationController
  def new
    @order = Order.new

    current_user.default_address.try :copy_to, @order
  end
end
