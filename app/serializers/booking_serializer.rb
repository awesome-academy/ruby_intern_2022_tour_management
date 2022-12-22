class BookingSerializer < ActiveModel::Serializer
  attributes :id, :status
  belongs_to :user
  belongs_to :tour_schedule
end
