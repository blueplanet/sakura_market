class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :journal

  default_scope { order(created_at: :desc).includes(:user) }

  after_create :send_mail_to_journal_owner

  private

  def send_mail_to_journal_owner
    JournalMailer.commented(self).deliver
  end
end
