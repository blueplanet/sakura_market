require 'spec_helper'

describe JournalsController do
  let(:user) { FactoryGirl.create :user }
  before { sign_in user }

  describe '#create' do
    context 'invalid params' do
      before { post :create, journal: { title: nil } }
      it { expect(response).to render_template(:new) }
    end
  end

  describe '#index' do
    it '200 ok' do
      get :index
      expect(response).to be_success
    end
  end
end
