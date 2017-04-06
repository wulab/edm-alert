require 'rails_helper'

feature "User creates an account" do
  context "by navigating from landing page" do
    it "creates with valid inputs successfully" do
      location = create(:location)

      visit root_path
      click_link "สมัคร"
      fill_out_account_creation_form(full_name: 'John Doe', location: location)
      click_button "สมัคร"
      expect(page).to have_content("Welcome! You have signed up successfully.")
      expect(page).to have_content("สวัสดีคุณ John Doe")
      expect(page)
        .to have_content("คุณอยู่ในพื้นที่ #{location.district}, #{location.province}")
    end

    it "creates with non-existent location input unsuccessfully" do
      location = build(:location)

      visit root_path
      click_link "สมัคร"
      fill_out_account_creation_form(location: location)
      click_button "สมัคร"
      expect(page).to have_content("รหัสไปรษณีย์ไม่ถูกต้อง")
    end
  end

  context "by registration button from landing page" do
    it "creates with valid inputs successfully" do
      location = create(:location)

      visit root_path
      click_link "เริ่มใช้เลย ฟรี"
      fill_out_account_creation_form(location: location)
      click_button "สมัคร"
      expect(page).to have_content("Welcome! You have signed up successfully.")
    end
  end
end
