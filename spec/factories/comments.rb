FactoryGirl.define do
  factory :comment do
    user
    journal
    sequence(:content) { |n| "comment content #{n}" }
  end
end
