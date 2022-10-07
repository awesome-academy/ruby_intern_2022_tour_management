class Tour < ApplicationRecord
  has_many_attached :images

  has_many :reviews, dependent: :destroy
  has_many :tour_schedules, dependent: :destroy

  scope :time_desc, ->{order updated_at: :desc}
end
