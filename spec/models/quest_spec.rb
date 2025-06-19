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

  describe "validations" do
    it "is valid with a title" do
      quest = Quest.new(title: "Valid Quest")
      expect(quest).to be_valid
    end

    it "is invalid without a title" do
      quest = Quest.new(title: nil)
      expect(quest).not_to be_valid
    end

    it "is invalid with a blank title" do
      quest = Quest.new(title: "")
      expect(quest).not_to be_valid
    end

    it "can't be created with a nil title" do
      expect {
        Quest.create!(title: nil)
      }.to raise_error(ActiveRecord::RecordInvalid, /Title can't be blank/)
    end
  end
end
