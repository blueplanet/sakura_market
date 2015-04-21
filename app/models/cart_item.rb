# == Schema Information
#
# Table name: cart_items
#
#  id         :integer          not null, primary key
#  product_id :integer
#  quantity   :integer          default(1)
#  created_at :datetime
#  updated_at :datetime
#  cart_id    :integer
#

class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  delegate :name, :price, to: :product
end
