class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
    @order = Order.new cart: current_cart

    current_user.default_address.try :copy_to, @order
  end

  def create
    @order = Order.new order_params.merge(user: current_user, cart: current_cart)
    if @order.save
      session[:cart_id] = nil
      redirect_to root_path, notice: t('.created')
    else
      render :new
    end
  end

  def show
    @order = Order.find params[:id]
    @items = @order.cart.items.page params[:page]
  end

  private
    def order_params
      params.require(:order).permit(:name, :tel, :zipcode, :address,
        :delivery_day, :delivery_time, :postage, :fee, :tax, :total)
    end
end
