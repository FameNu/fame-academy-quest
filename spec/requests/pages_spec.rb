require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /index" do
    it "returns http redirect" do
      get "/pages"
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET /" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /brag" do
    it "returns http success" do
      get "/brag"
      expect(response).to have_http_status(:success)
    end
  end
end
