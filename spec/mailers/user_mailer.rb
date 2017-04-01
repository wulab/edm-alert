require 'rails_helper'

describe UserMailer do
  it "is sent to the given email" do
    expect(user_email.to).to eq(%w(email@example.com))
  end

  it "specifies the subject" do
    expect(user_email.subject).to eq(
      "ยินดีต้อบรับสู่ระบบรับข่าวเตือนภัยจาก SafetyAlert"
    )
  end

  it "specifies the welcome message" do
    expect(user_email).to(
      have_body_text("คุณทำการสมัครรับข่าวเตือนภัยเรียบร้อย")
    )
  end

  it 'is sent from SafetyAlert' do
    expect(user_email.from).to include(ENV["SUPPORT_EMAIL"])
  end

  def user_email
    location = build(:location)
    user = build(:user, email: "email@example.com", location: location)
    UserMailer.welcome_user(user)
  end
end
