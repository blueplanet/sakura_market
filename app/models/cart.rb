class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :items, class_name: 'CartItem'

  def total_amount
    items.inject(0) { |sum, item| sum + item.product.price * item.quantity }
  end
end
