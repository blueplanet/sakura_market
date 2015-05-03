require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

  describe "GET #show" do
    let(:profile) { create :profile }
    it "returns http success" do
      get :show, id: profile.id
      expect(response).to have_http_status(:success)
    end
  end
end
