class TourSerializer < ActiveModel::Serializer
  attributes :id, :title, :description
  has_many :reviews
  has_many :tour_schedules
end
