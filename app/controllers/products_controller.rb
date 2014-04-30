class ProductsController < ApplicationController
  def index
    @products = Product.order(:display_no).page(params[:page]).per(9)
  end
end
