require 'spec_helper'

RSpec.describe Comment, type: :model do
  describe 'after_create' do
    it 'mail shound be sent' do
      FactoryGirl.create(:comment)

      last_mail = ActionMailer::Base.deliveries.last
      expect(last_mail).not_to be_nil
    end
  end
end
