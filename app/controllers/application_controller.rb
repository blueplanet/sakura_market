class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_cart

  private
    def current_cart
      return nil unless current_user
      cart = session[:cart_id].blank? ? Cart.find_or_create_by(user: current_user) : Cart.find(session[:cart_id])
      session[:cart_id] ||= cart.id

      cart
    end
end
