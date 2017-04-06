module SignUpHelpers
  def fill_out_account_creation_form(user_attributes={})
    user = build(:user, user_attributes)

    fill_in "ชื่อ-นามสกุล", with: user.full_name
    fill_in "อีเมล์", with: user.email
    within ".form-inputs .user_password" do
      fill_in "พาสเวิร์ด", with: user.password
    end
    within ".form-inputs .user_password_confirmation" do
      fill_in "ยืนยันพาสเวิร์ด", with: user.password
    end
    fill_in "รหัสไปรษณีย์", with: user.location.postal_code
  end
end
