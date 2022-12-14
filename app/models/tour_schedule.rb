class TourSchedule < ApplicationRecord
  belongs_to :tour
  has_many :bookings, dependent: :destroy

  ALLOWED_PARAMS = %i(start_date end_date).freeze

  validates :title, presence: true,
            length: {maximum: Settings.tour_schedule.title.max_length}
  validates :end_date, :start_date, presence: true
  validate :validate_time, if: ->{start_date.present? && end_date.present?}

  scope :by_start_date, (lambda do |start_date|
    where "start_date >= ?", start_date.presence || DateTime.now
  end)
  scope :by_end_date, (lambda do |end_date|
    where "end_date <= ?", end_date if end_date.present?
  end)
  scope :get_from_current_day, ->{where "start_date >= ?", DateTime.now}
  scope :by_tour_id, ->(id){where tour_id: id}

  delegate :id, :title, to: :tour, prefix: true

  def start_date_format
    start_date.strftime Settings.date_time.format
  end

  def end_date_format
    end_date.strftime Settings.date_time.format
  end

  private
  def validate_time
    return if end_date > start_date

    errors.add :end_date,
               I18n.t(".time_schedule_error")
  end
end
