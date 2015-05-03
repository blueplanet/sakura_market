FactoryGirl.define do
  factory :profile do
    sequence(:nick_name) { |n| "nick_name #{n}" }

    trait :with_avatar do
      avatar { Rack::Test::UploadedFile.new(File.open(Rails.root.join("spec/fixtures/images/cat.jpg"))) }
    end
  end
end
