FactoryGirl.define do
  factory :order do
    name 'name'
    tel '03-3535-4493'
    zipcode '136-5571'
    address '東京都青山一丁目1-32-5'
    delivery_day { Order.new.send(:business_days_after, 5) }
    delivery_time :t8_12
    user
    cart
  end
end
