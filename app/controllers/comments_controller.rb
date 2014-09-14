class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_journal

  def create
    @journal.comments.create! comment_param.merge(user: current_user)
    redirect_to @journal, notice: t('.created')
  end

  private

  def set_journal
    @journal = Journal.find params[:journal_id]
  end

  def comment_param
    params.require(:comment).permit(:content)
  end
end
