describe QuestsController, type: :controller do
  let(:valid_attributes) { { title: "New Quest" } }
  let(:invalid_attributes) { { title: nil } }
  describe "POST #create" do
    before do
      Quest.destroy_all
    end

    it "creates a new quest with valid attributes" do
      expect {
        post :create, params: { quest: valid_attributes }
      }.to change(Quest, :count).by(1)
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq("Quest was successfully created.")

      expect(Quest.last.title).to eq("New Quest")
      expect(Quest.last.completed).to eq(false)
    end

    it "does not create a new quest with invalid attributes" do
      expect {
        post :create, params: { quest: invalid_attributes }
      }.not_to change(Quest, :count)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq("Failed to create quest.")
    end
  end
end
