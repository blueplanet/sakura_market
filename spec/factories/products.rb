# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  image       :string
#  price       :integer
#  description :text
#  display_no  :integer
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    sequence(:name) {|n| "product #{n}"}
    sequence(:price) {|n| n * 1000 }
    sequence(:display_no) {|n| n }
    image { Rack::Test::UploadedFile.new(File.open(Rails.root.join("spec/fixtures/images/niku.jpg"))) }
  end
end
