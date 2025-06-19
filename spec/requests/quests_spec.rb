require 'rails_helper'

describe "Quests", type: :request do
  let(:valid_attributes) { { quest: { title: "New Quest" } } }
  let(:invalid_attributes) { { quest: { title: nil } } }
  describe "POST /quests" do\
    it "creates a new quest with valid attributes" do
      expect {
        post quests_path, params: valid_attributes
      }.to change(Quest, :count).by(1)
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq("Quest was successfully created.")
    end

    it "does not create a new quest with invalid attributes" do
      expect {
        post quests_path, params: invalid_attributes
      }.not_to change(Quest, :count)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq("Failed to create quest.")
    end
  end

  describe "PATCH /quests/:id" do
    let!(:quest) { Quest.create!(title: "Existing Quest") }

    it "can't update title" do
      patch quest_path(quest), params: { quest: { title: "Updated Quest" } }
      quest.reload
      expect(quest.title).to eq("Existing Quest")
      expect(response).to redirect_to(root_path)
    end

    it "does not update a quest with invalid attributes" do
      patch quest_path(quest), params: { quest: { title: nil } }
      expect(response).to redirect_to(root_path)

      quest.reload
      expect(quest.title).to eq("Existing Quest")
    end
  end

  describe "DELETE /quests/:id" do
    let!(:quest) { Quest.create!(title: "Quest to be deleted") }

    it "deletes a quest" do
      expect {
        delete quest_path(quest)
      }.to change(Quest, :count).by(-1)
      expect(response).to redirect_to(root_path)
    end
  end
end
