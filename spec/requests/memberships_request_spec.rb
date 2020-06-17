require 'rails_helper'

RSpec.describe "Memberships", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/memberships/show"
      expect(response).to have_http_status(:success)
    end
  end

end
