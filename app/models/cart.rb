class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :items, class_name: 'CartItem'

  def total_amount
    items.to_a.sum { |item| item.price * item.quantity }
  end
end
