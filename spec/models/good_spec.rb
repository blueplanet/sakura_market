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

require 'rails_helper'

RSpec.describe Good, type: :model do
  describe 'after_create' do
    it 'mail shound be sent' do
      good = FactoryGirl.create(:good)

      last_mail = ActionMailer::Base.deliveries.last
      expect(last_mail).not_to be_nil
      expect(last_mail.to).to include good.journal.user.email
    end
  end
end
