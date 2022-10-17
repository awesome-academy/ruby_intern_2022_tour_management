class Tour < ApplicationRecord
  has_many_attached :images

  has_many :reviews, dependent: :destroy
  has_many :tour_schedules, dependent: :destroy

  ALLOWED_PARAMS = %i(title active).freeze

  scope :by_id, ->(id){where id: id}
  scope :time_desc, ->{order updated_at: :desc}
  scope :by_title, ->(title){where "title LIKE ?", "%#{title}%"}
  scope :status, ->(status){where(active: status)}
end
