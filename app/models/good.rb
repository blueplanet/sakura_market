class Good < ActiveRecord::Base
  belongs_to :journal
  belongs_to :user

  after_create :send_gooded_mail

  private

  def send_gooded_mail
    JournalMailer.gooded(self).deliver
  end
end
