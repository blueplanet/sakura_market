# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  journal_id :integer
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :comment do
    user
    journal
    sequence(:content) { |n| "comment content #{n}" }
  end
end
