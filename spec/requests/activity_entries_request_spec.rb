require 'rails_helper'

RSpec.describe "ActivityEntries", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/activity_entries/show"
      expect(response).to have_http_status(:success)
    end
  end

end
