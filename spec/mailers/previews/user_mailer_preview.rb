# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome_user
  def welcome_user
    user = User.last
    UserMailer.welcome_user(user)
  end

end
