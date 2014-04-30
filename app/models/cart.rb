class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items

  def total_amount
    cart_items.inject(0) { |sum, item| sum + item.product.price * item.quantity }
  end
end
