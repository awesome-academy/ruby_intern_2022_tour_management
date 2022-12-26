class Ability
  include CanCan::Ability

  def initialize user
    can :read, Tour
    can :read, TourSchedule
    can :read, Review
    can :create, Booking

    return if user.blank?

    can %i(destroy read), Booking, user: user
    can :create, Review
    can %i(update destroy), Review, user: user

    return if user.normal?

    cannot :destroy, Booking
    can %i(create update destroy import), Tour
    can %i(create update destroy), TourSchedule
    can :update, Booking
  end
end
