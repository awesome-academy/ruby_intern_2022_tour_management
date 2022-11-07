class BookMailer < ApplicationMailer
  def booking_confirmation user, status
    @user = user
    @status = status

    mail to: user.email, subject: t(".subject")
  end
end
