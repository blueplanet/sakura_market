class OrdersController < ApplicationController
  def new
    @order = Order.new cart: current_cart

    current_user.default_address.try :copy_to, @order
  end

  def create
    @order = Order.new order_params.merge(user: current_user)
    if @order.save
      current_cart.destroy
      session[:cart_id] = nil
      redirect_to root_path, notice: t('.created')
    else
      render :new
    end
  end

  private
    def order_params
      params.require(:order).permit(:name, :tel, :zipcode, :address, 
        :delivery_day, :delivery_time, :postage, :fee, :tax, :total)
    end
end
