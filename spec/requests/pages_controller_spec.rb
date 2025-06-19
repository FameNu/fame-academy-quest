describe PagesController, type: :controller do
  describe "GET index method" do
    it "return http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns @quests" do
      get :index
      expect(assigns(:quests)).not_to be_nil
    end
  end

  describe "GET brag" do
    it "returns http success" do
      get :brag
      expect(response).to have_http_status(:success)
    end
  end
end
