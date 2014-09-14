class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :journal

  default_scope { order(created_at: :desc).includes(:user) }

  after_create :send_commented_mail

  private

  def send_commented_mail
    JournalMailer.commented(self).deliver
  end
end
