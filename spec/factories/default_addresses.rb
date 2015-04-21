# == Schema Information
#
# Table name: default_addresses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  tel        :string
#  zipcode    :string
#  address    :string
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :default_address do
    name 'name'
    tel '03-3535-4493'
    zipcode '136-5571'
    address '東京都青山一丁目1-32-5'
  end
end
