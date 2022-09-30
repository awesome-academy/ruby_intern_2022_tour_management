class Tour < ApplicationRecord
  has_many_attached :images

  has_many :reviews, dependent: :destroy
  has_many :tour_schedules, dependent: :destroy

  scope :by_id, ->(id){where id: id}
  scope :time_desc, ->{order updated_at: :desc}
end
