require 'rails_helper'

RSpec.describe DefaultAddressesController, type: :controller do
  before { sign_in :user, create(:user) }

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end
end
