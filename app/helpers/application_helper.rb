module ApplicationHelper
  def alert_helper(alert_class='default', content)
    content_tag 'div', class: "alert alert-#{alert_class} alert-dismissable" do
      concat content_tag 'button', raw('&times;'), class: "close", :'aria-hidden' => 'true', data: {dismiss: 'alert'}
      concat content
    end
  end

  def current_cart
    return nil unless current_user
    cart = session[:cart_id].blank? ? Cart.find_or_create_by(user: current_user) : Cart.find(session[:cart_id])
    session[:cart_id] ||= cart.id

    cart
  end
end
