class JournalsController < ApplicationController
  before_action :set_journal, only: [:show, :edit, :update, :destroy]

  def index
    @journals = Journal.all.page params[:page]
  end

  def new
    @journal = Journal.new
  end

  def create
    @journal = Journal.new(journal_params)

    respond_to do |format|
      if @journal.save
        format.html { redirect_to journals_path, notice: t('.created') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @journal.update(journal_params)
        format.html { redirect_to @journal, notice: 'Journal was successfully updated.' }
        format.json { render :show, status: :ok, location: @journal }
      else
        format.html { render :edit }
        format.json { render json: @journal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @journal.destroy
    respond_to do |format|
      format.html { redirect_to journals_url }
      format.json { head :no_content }
    end
  end

  private
    def set_journal
      @journal = Journal.find(params[:id])
    end

    def journal_params
      params.require(:journal).permit(:title, :body)
    end
end