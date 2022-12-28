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

  class << self
    def import_file file
      spreadsheet = Roo::Spreadsheet.open file
      return false if spreadsheet.first_row.blank?

      r = 1
      header = spreadsheet.row r
      while header[0].blank?
        r += 1
        header = spreadsheet.row r
      end

      tours = get_tour_informations spreadsheet, header, r

      return false if tours.empty?

      insert_all tours

      tours.size
    end

    private

    def get_tour_informations spreadsheet, header, row
      tours = []
      (row + 1..spreadsheet.last_row).each do |i|
        row  = [header, spreadsheet.row(i)].transpose.to_h

        tour = create_tour row

        tours << tour.attributes if tour.errors[:title].empty? &&
                                    tour.errors[:description].empty?
      end

      tours
    end

    def create_tour attributes
      tour = new attributes
      tour.created_at = DateTime.now
      tour.updated_at = DateTime.now

      tour.valid?

      tour
    end
  end

  private
  def validate_image
    return if images.count >= Settings.images.total_min

    errors.add(:images,
               "#{I18n.t('.images_count_error')} #{Settings.images.total_min}")
  end
end
