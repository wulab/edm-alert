require "rails_helper"

feature 'Users signs out' do
  scenario 'from home page' do
    user = create(:user, location: create(:location))
    visit root_path
    sign_in(user)
    user_should_be_signed_in

    sign_out
    user_should_be_signed_out
  end

  scenario 'from events page and return to home page' do
    user = create(:user, location: create(:location))
    visit root_path
    sign_in(user)
    user_should_be_signed_in

    visit events_path
    sign_out
    user_should_be_signed_out
    expect(current_path).to eq root_path
  end
end
