module UserHelpers
  def fill_out_account_creation_form(user_attributes={})
    user = build(:user, user_attributes)

    fill_in "user[full_name]", with: user.full_name
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    fill_in "user[password_confirmation]", with: user.password
    fill_in "user[postal_code]", with: user.location.postal_code
  end

  def sign_in(user)
    click_link "เข้าสู่ระบบ"
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_button "เข้าสู่ระบบ"
  end

  def sign_out
    click_link "ออกจากระบบ"
  end

  def user_should_be_signed_in
    expect(page).to have_content "ออกจากระบบ"
  end

  def user_should_be_signed_out
    expect(page).to have_content "เข้าสู่ระบบ"
  end
end
