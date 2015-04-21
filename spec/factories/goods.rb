# == Schema Information
#
# Table name: goods
#
#  id         :integer          not null, primary key
#  journal_id :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :good do
    journal
    user
  end
end
