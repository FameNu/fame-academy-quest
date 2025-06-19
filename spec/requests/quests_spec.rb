require 'rails_helper'

RSpec.describe "Quests", type: :request do
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
end
