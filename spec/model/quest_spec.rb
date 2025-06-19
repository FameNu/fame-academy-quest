require 'rails_helper'

describe Quest, type: :model do
  describe "default values" do
    it "has completed set to false by default" do
      quest = Quest.create!(title: "Default test")
      expect(quest.completed).to eq(false)
    end
  end
end
