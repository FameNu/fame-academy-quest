require "rails_helper"

describe "Pages", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "GET /index" do
    it "redirects to the quests page" do
      visit root_path
      expect(page).to have_current_path("/")
      expect(page).to have_content("Fame's Quest")
      expect(page).to have_content("Phuwamet Panjachalermrat")

      expect(page).to have_selector("input[type=text][placeholder='Enter quest title']")
      expect(page).to have_button("Create Quest")
    end
  end

  describe "GET /brag" do
    it "displays the brag page" do
      visit brag_path
      expect(page).to have_current_path(brag_path)
      expect(page).to have_content("Fame's Brag Document")
      expect(page).to have_link("< Back to My Quests", href: root_path)
    end
  end

  describe "navigate page" do
    it "navigates to the brag page" do
      visit root_path
      click_link "Fame's Brag Document"
      expect(page).to have_current_path(brag_path)

      expect(page).to have_content("Fame's Brag Document")
      expect(page).to have_link("< Back to My Quests", href: root_path)
    end

    it "navigates back to the quests page" do
      visit brag_path
      click_link "< Back to My Quests"
      expect(page).to have_current_path(root_path)

      expect(page).to have_content("Fame's Quest")
      expect(page).to have_content("Phuwamet Panjachalermrat")
      expect(page).to have_selector("input[type=text][placeholder='Enter quest title']")
      expect(page).to have_button("Create Quest")
    end
  end
end
