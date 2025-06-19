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

  describe "PATCH #update" do
    let!(:quest) { Quest.create!(valid_attributes) }

    it "updates the quest's completed status" do
      expect {
        patch :update, params: { id: quest.id }
      }.to change { quest.reload.completed }.from(false).to(true)
    end

    it "redirects to the root path after updating" do
      patch :update, params: { id: quest.id }
      expect(response).to redirect_to(root_path)
    end

    it "not assigns quest id" do
      expect {
        patch :update, params: { id: "" }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "DELETE #destroy" do
  let!(:quest) { Quest.create!(valid_attributes) }

  it "deletes the quest and redirects to the root path" do
    expect {
      delete :destroy, params: { id: quest.id }
    }.to change(Quest, :count).by(-1)
    expect(response).to redirect_to(root_path)
  end

  it "not assigns quest id, number of Quest will not change" do
    quest_before_delete = Quest.count
    expect {
      delete :destroy, params: { id: "" }
    }.to raise_error(ActiveRecord::RecordNotFound)
    expect(Quest.count).to eq(quest_before_delete)
  end

  it "delete quest with same id will not change the number of Quest" do
    atr = { title: "Another Quest" }
    Quest.create!(atr)
    expect {
      delete :destroy, params: { id: quest.id }
    }.to change(Quest, :count).by(-1)

    quest_before_delete_second_time = Quest.count
    expect {
      delete :destroy, params: { id: quest.id }
    }.to raise_error(ActiveRecord::RecordNotFound)
    expect(Quest.count).to eq(quest_before_delete_second_time)
  end
  end
end
