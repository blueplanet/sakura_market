class JournalMailer < ActionMailer::Base
  default from: "from@example.com"

  def commented(comment)
    @comment = comment

    mail to: @comment.journal.user.email, content_type: "text/html"
  end
end
