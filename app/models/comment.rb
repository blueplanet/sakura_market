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

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :journal

  default_scope { order(created_at: :desc).includes(:user) }

  after_create :send_commented_mail

  private

  def send_commented_mail
    JournalMailer.commented(self).deliver_now
  end
end
