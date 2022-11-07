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

  JOIN_TABLE = [:user, {tour_schedule: :tour}].freeze

  scope :by_user_name, (lambda do |name|
                          joins(:user)
                            .where "users.name LIKE ?", "%#{name}%"
                        end)
  scope :by_schedule_name, (lambda do |name|
                              joins(:tour_schedule)
                                .where("tour_schedules.title LIKE ?",
                                       "%#{name}%")
                            end)
  scope :by_start_date, (lambda do |start_date|
                           if start_date.present?
                             joins(:tour_schedule)
                               .where("tour_schedules.start_date >= ?",
                                      start_date)
                           end
                         end)
  scope :by_end_date, (lambda do |end_date|
                         if end_date.present?
                           joins(:tour_schedule)
                             .where("tour_schedules.end_date <= ?",
                                    end_date)
                         end
                       end)
  scope :by_status, ->(status){where status: status if status.present?}
  scope :by_user_id, ->(id){where user_id: id}
  scope :order_by_status, ->{order :status}

  def show_status
    I18n.t(".#{status}")
  end
end
