FactoryGirl.define do
  factory :cart do
    user
    items { FactoryGirl.create_list :cart_item, 3 }
  end
end
