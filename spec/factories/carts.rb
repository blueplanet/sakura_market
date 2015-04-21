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

FactoryGirl.define do
  factory :cart do
    user
    items { FactoryGirl.create_list :cart_item, 3 }
  end
end
