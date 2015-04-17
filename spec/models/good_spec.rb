require 'spec_helper'

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
