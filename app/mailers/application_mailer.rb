class ApplicationMailer < ActionMailer::Base
  default from: "nonreply@gmail.com"
  layout "mailer"
end
