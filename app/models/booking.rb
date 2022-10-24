class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour_schedule

  validates :user_id, uniqueness: {scope: :tour_schedule_id}

  enum status: {pending: 0, accept: 1, cancel: 2}

  delegate :title, :start_date_format, :end_date_format,
           to: :tour_schedule
  delegate :name, to: :user, prefix: true

  COLORS = {
    "pending" => "primary",
    "accept" => "success",
    "cancel" => "danger"
  }.freeze

  scope :by_user_id, ->(id){where user_id: id}
  scope :order_by_status, ->{order :status}

  def show_status
    I18n.t(".#{status}")
  end
end
