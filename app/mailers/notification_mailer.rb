class NotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.event_warning.subject
  #
  def event_warning(user, event)
    @user  = user
    @event = event
    mail to: @user.email, subject: @event.title
  end
end
