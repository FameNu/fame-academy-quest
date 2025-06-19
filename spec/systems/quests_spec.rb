require "rails_helper"

describe "Quests", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
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
    let(:quest_valid_attributes) { { title: "Capybara Quest" } }

    it "creates with valid attributes" do
      fill_in "quest_title", with: quest_valid_attributes[:title]
      click_button "Create Quest"

      expect(page).not_to have_content("No quests available.")
      expect(page).to have_selector("li.list-row", count: 1)
      expect(page).to have_selector("li.list-row", text: quest_valid_attributes[:title])
      expect(page).to have_selector("input[type=checkbox][name='completed']")
      expect(page).to have_button("Remove")
    end

    it "creates multiple quests and shows newest on top" do
      fill_in "quest_title", with: "Quest 1"
      click_button "Create Quest"
      expect(page).to have_selector("li.list-row", count: 1)

      fill_in "quest_title", with: "Quest 2"
      click_button "Create Quest"
      expect(page).to have_selector("li.list-row", count: 2)

      expect(all("li.list-row").first).to have_text("Quest 2")
    end

    it "does not create a quest with empty title" do
      click_button "Create Quest"
      expect(page).to have_selector("li.list-row", count: 0)
    end
  end

  describe "mark a quest as completed and un-completed" do
    before do
      fill_in "quest_title", with: "Quest"
      click_button "Create Quest"
      expect(page).to have_selector("li.list-row", count: 1)
    end

    it "marks a quest as completed" do
      first("input[type=checkbox]").click
      expect(page).to have_selector("input[type=checkbox][checked]")
    end

    it "un-completes a quest" do
      first("input[type=checkbox]").click
      expect(page).to have_selector("input[type=checkbox][checked]")

      first("input[type=checkbox]").click
      expect(page).not_to have_selector("input[type=checkbox][checked]")
    end
  end

  describe "remove a quest" do
    before do
      fill_in "quest_title", with: "Quest to be removed"
      click_button "Create Quest"
      expect(page).to have_selector("li.list-row", count: 1)
    end

    it "removes a quest" do
      first("button", text: "Remove").click
      expect(page).to have_selector("li.list-row", count: 0)
      expect(page).to have_content("No quests available.")
    end

    it "removes multiple quests" do
      fill_in "quest_title", with: "Another Quest"
      click_button "Create Quest"
      expect(page).to have_selector("li.list-row", count: 2)

      all("button", text: "Remove").each(&:click)
      expect(page).to have_selector("li.list-row", count: 0)
      expect(page).to have_content("No quests available.")
    end
  end
end
