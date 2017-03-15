class UserMailer < ApplicationMailer

  # Welcome email to new user.
  def welcome_user(user)
    @user  = user

    mail(
      to: @user.email,
      subject: "ยินดีต้อบรับสู่ระบบรับข่าวเตือนภัยจาก SafetyAlert"
    )
  end
end
