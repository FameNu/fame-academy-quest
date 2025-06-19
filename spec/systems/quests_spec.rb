require "rails_helper"

describe "Quests", type: :system do
  before do
    driven_by(:rack_test)
    Quest.destroy_all
    visit root_path
  end

  describe "empty quests list" do
   it "shows an empty list" do
      expect(page).to have_current_path(root_path)
      expect(page).to have_content("No quests available.")
    end
  end

  describe "create a quest" do
    before do
      Quest.destroy_all
      visit root_path
    end
    let(:quest_valid_attributes) do
      {
        title: "Capybara Quest"
      }
    end

    it "creates with valid attributes" do
      fill_in "quest_title", with: quest_valid_attributes[:title]
      click_button "Create Quest"

      quests = all("li.list-row")

      expect(page).to have_current_path(root_path)
      expect(page).not_to have_content("No quests available.")
      expect(quests.count).to eq(1)
      expect(quests.first).to have_content(quest_valid_attributes[:title])
      expect(quests.first).to have_selector("input[type=checkbox][name='completed']")
      expect(quests.first).to have_selector("button", text: "Remove")
    end

    it "creates with valid attributes and shows the new quest at the top" do
      fill_in "quest_title", with: quest_valid_attributes[:title]
      click_button "Create Quest"
      fill_in "quest_title", with: "#{quest_valid_attributes[:title]}-2"
      click_button "Create Quest"

      quests = all("li.list-row")

      expect(page).to have_current_path(root_path)
      expect(page).not_to have_content("No quests available.")
      expect(quests.count).to eq(2)
      expect(quests.first).to have_content("#{quest_valid_attributes[:title]}-2")
      expect(quests.first).to have_selector("input[type=checkbox][name='completed']")
      expect(quests.first).to have_selector("button", text: "Remove")
    end

    it "click create without filling in the title" do
      click_button "Create Quest"

      expect(page).to have_current_path(root_path)
      expect(all("li.list-row").count).to eq(0)
    end
  end

  describe "mark a quest as completed and un-complete" do
    before do
      fill_in "quest_title", with: "Capybara Quest"
      click_button "Create Quest"
    end

    it "marks a quest as completed" do
      quests = all("li.list-row")
      expect(quests.count).to eq(1)

      check "completed"
      expect(quests.first).to have_selector("input[type=checkbox][name='completed'][checked]")
    end

    it "un-completes a quest" do
      quests = all("li.list-row")
      expect(quests.count).to eq(1)

      check "completed"
      uncheck "completed"
      expect(quests.first).to have_selector("input[type=checkbox][name='completed']")
      expect(quests.first).not_to have_selector("input[type=checkbox][name='completed'][checked]")
    end

    it "marks multiple quests as completed" do
      fill_in "quest_title", with: "Capybara Quest 2"
      click_button "Create Quest"
      fill_in "quest_title", with: "Capybara Quest 3"
      click_button "Create Quest"

      quests = all("li.list-row")
      expect(quests.count).to eq(3)

      quests.each do |quest|
        checkbox = quest.find("input[type=checkbox][name='completed']")
        checkbox.click

        expect(quest).to have_selector("input[type=checkbox][name='completed'][checked]")
        expect(quest).to have_selector("button", text: "Remove")
      end
    end

    it "marks multiple quests as completed and un-completes one" do
      fill_in "quest_title", with: "Capybara Quest 2"
      click_button "Create Quest"
      fill_in "quest_title", with: "Capybara Quest 3"
      click_button "Create Quest"

      quests = all("li.list-row")
      expect(quests.count).to eq(3)

      quests.each do |quest|
        checkbox = quest.find("input[type=checkbox][name='completed']")
        checkbox.click

        expect(quest).to have_selector("input[type=checkbox][name='completed'][checked]")
        expect(quest).to have_selector("button", text: "Remove")
      end

      quests.first.find("input[type=checkbox][name='completed']").click
      expect(quests.first).not_to have_selector("input[type=checkbox][name='completed'][checked]")
    end
  end

  describe "remove a quest" do
    before do
      fill_in "quest_title", with: "Capybara Quest"
      click_button "Create Quest"
    end

    it "removes a quest" do
      quests = all("li.list-row")
      expect(quests.count).to eq(1)

      click_button "Remove"

      after_click_remove = all("li.list-row")
      expect(after_click_remove.count).to eq(0)
      expect(page).to have_content("No quests available.")
    end

    it "removes a quest and shows the remaining quests" do
      fill_in "quest_title", with: "Capybara Quest 2"
      click_button "Create Quest"
      fill_in "quest_title", with: "Capybara Quest 3"
      click_button "Create Quest"
      fill_in "quest_title", with: "Capybara Quest 4"
      click_button "Create Quest"

      quests = all("li.list-row")
      quests.each do |quest|
        expect(quest).to have_selector("input[type=checkbox][name='completed']")
        expect(quest).to have_selector("button", text: "Remove")
      end

      expect(quests.count).to eq(4)
      # remove the second quest
      quests[1].find("button", text: "Remove").click
      after_click_remove = all("li.list-row")
      expect(after_click_remove.count).to eq(3)
    end
  end
end
