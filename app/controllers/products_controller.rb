class ProductsController < ApplicationController
  def index
    @products = Product.order(:display_no).page params[:page]
  end
end
