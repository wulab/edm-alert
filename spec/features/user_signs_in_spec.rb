require "rails_helper"

feature 'Users signs in' do
  scenario 'with valid email and password' do
    user = create(:user, location: create(:location))
    visit root_path
    sign_in(user)
    user_should_be_signed_in
  end

  scenario 'with invalid email and password' do
    visit root_path
    sign_in(build(:user))
    expect(page).to have_content "Invalid Email or password."
  end
end
