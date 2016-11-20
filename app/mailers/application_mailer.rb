class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@#{Rails.application.secrets.default_host}"
  layout 'mailer'
end
