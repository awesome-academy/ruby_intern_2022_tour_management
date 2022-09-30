class Tour < ApplicationRecord
  has_many_attached :images
  has_many :reviews, dependent: :destroy
  has_many :tour_schedules, dependent: :destroy
  accepts_nested_attributes_for :tour_schedules, allow_destroy: true

  validates :title, presence: true,
            length: {maximum: Settings.tour.title.max_length}
  validates :description, presence: true,
            length: {maximum: Settings.tour.description.max_length}
  validate :validate_image

  ALLOWED_PARAMS = %i(title active).freeze
  CREATE_ATTRS = [:description, :title, :active, {images: [],
                                                  tour_schedules_attributes: [
                                                    :id, :title, :start_date,
                                                    :end_date, :_destroy
                                                  ]}].freeze

  scope :by_id, ->(id){where id: id}
  scope :time_desc, ->{order updated_at: :desc}
  scope :by_title, ->(title){where "title LIKE ?", "%#{title}%"}
  scope :actived, ->(val){where active: val if val.present?}

  def show_active
    I18n.t(".#{active}")
  end

  def has_bookings?
    tour_schedules.includes(:bookings).any?{|s| s.bookings.present?}
  end

  private
  def validate_image
    return if images.count >= Settings.images.total_min

    errors.add(:images,
               "#{I18n.t('.images_count_error')} #{Settings.images.total_min}")
  end
end
