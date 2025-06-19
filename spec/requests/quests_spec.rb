require 'rails_helper'

RSpec.describe "Quests", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/quests/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/quests/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/quests/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
