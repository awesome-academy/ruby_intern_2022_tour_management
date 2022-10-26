class SendBookingConfirmationJob
  include Sidekiq::Job
  sidekiq_options retry: 5

  def perform user_id, status
    user = User.find user_id
    BookMailer.booking_confirmation(user,
                                    status).deliver_now
  end
end
