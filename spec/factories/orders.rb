# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  name          :string
#  tel           :string
#  zipcode       :string
#  address       :string
#  delivery_day  :date
#  delivery_time :string
#  created_at    :datetime
#  updated_at    :datetime
#  user_id       :integer
#

FactoryGirl.define do
  factory :order do
    name 'name'
    tel '03-3535-4493'
    zipcode '136-5571'
    address '東京都青山一丁目1-32-5'
    delivery_day { 5.business_days.from_now }
    delivery_time :t8_12
    user
    cart
  end
end
