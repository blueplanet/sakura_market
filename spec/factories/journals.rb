FactoryGirl.define do
  factory :journal do
    sequence(:title) {|n| "日記タイトル #{n}"}
    sequence(:body) {|n| "日記内容！ #{n}"}
    user
  end
end
