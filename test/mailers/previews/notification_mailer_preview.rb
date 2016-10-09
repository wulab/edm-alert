# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notification_mailer/event_warning
  def event_warning
    user  = User.last
    event = Event.last
    NotificationMailer.event_warning(user, event)
  end

end
