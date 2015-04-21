# == Schema Information
#
# Table name: journals
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  image      :string
#

FactoryGirl.define do
  factory :journal do
    sequence(:title) {|n| "日記タイトル #{n}"}
    sequence(:body) {|n| "日記内容！ #{n}"}
    user
  end
end
