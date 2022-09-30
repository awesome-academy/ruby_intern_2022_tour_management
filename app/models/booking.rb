class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour_schedule

  enum status: {pending: 0, accept: 1, cancel: 2}

  scope :by_user_id, ->(id){where user_id: id}
  scope :oder_by_status, ->{order :status}

  def show_status
    I18n.t(".#{status}").to_s
  end
end
