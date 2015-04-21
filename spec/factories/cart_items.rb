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

FactoryGirl.define do
  factory :cart_item do
    product
    quantity 1
  end
end
