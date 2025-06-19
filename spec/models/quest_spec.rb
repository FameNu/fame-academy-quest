require 'rails_helper'

describe Quest, type: :model do
  describe "default values" do
    quest_title = "Default Quest"
    quest = Quest.create!(title: quest_title)

    it "has a title field" do
      expect(quest.title).not_to be_nil
      expect(quest.title).to eq(quest_title)
    end

    it "has completed set to false by default" do
      expect(quest.completed).to eq(false)
    end
  end
end
