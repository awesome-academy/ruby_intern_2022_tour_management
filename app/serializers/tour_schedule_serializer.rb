class TourScheduleSerializer < ActiveModel::Serializer
  attributes :id, :title, :start_date, :end_date
  belongs_to :tour
end
