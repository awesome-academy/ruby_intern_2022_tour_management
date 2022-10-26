class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("admin_mail", nil)
  layout "mailer"
end
