class ApplicationMailer < ActionMailer::Base
  default from: Devise.mailer_sender
  layout 'mailer'

  add_template_helper HtmlHelper
end
