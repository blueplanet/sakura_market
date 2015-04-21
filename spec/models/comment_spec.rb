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

require 'spec_helper'

RSpec.describe Comment, type: :model do
  describe 'after_create' do
    it 'mail shound be sent' do
      comment = FactoryGirl.create(:comment)

      last_mail = ActionMailer::Base.deliveries.last
      expect(last_mail).not_to be_nil
      expect(last_mail.to).to include comment.journal.user.email
    end
  end
end
