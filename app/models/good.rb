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

class Good < ActiveRecord::Base
  belongs_to :journal
  belongs_to :user

  after_create :send_gooded_mail

  private

  def send_gooded_mail
    JournalMailer.gooded(self).deliver
  end
end
