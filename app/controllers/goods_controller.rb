class GoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_journal

  def create
    @journal.goods.create! user: current_user
    render nothing: true, status: :ok
  end

  private

  def set_journal
    @journal = Journal.find params[:journal_id]
  end
end
