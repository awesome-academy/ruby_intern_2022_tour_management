class BookingAbility
  include CanCan::Ability
  def initialize user
    return if user.blank? || user.admin?

    can %i(read create destroy), Booking
  end
end
