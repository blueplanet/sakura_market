# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  order_id   :integer
#  checkouted :boolean
#

class Cart < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  has_many :items, class_name: 'CartItem'

  def total_amount
    items.to_a.sum { |item| item.price * item.quantity }
  end
end
