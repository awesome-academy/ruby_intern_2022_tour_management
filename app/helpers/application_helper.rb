module ApplicationHelper
  include Pagy::Frontend

  def get_path
    params[:controller] == "admin/static_pages" ? admin_root_path : root_path
  end

  def get_reviews tour
    tour.reviews.includes(:user)
  end

  def get_cancel_path tour_id
    tour_id.nil? ? admin_root_path : admin_tour_path(tour_id)
  end

  def get_form_path tour_id
    tour_id.nil? ? admin_tours_path : admin_tour_path(tour_id)
  end

  def tour_images
    @tour.images.includes(:blob)
  end

  def get_root_path
    current_user&.admin? ? admin_root_path : root_path
  end

  def tour_id booking
    booking.tour_schedule.tour_id
  end

  def get_link_to tour
    if tour.has_bookings?
      tour_active_link tour
    else
      link_to t(".delete_tour"), admin_tour_path(tour.id), method: :delete,
              data: {confirm: t(".confirm_delete")}, class: "btn btn-danger"
    end
  end

  def tour_active_link tour
    text = [:show, :success]
    display = Settings.tour.displays.show

    if tour.active?
      text = [:delete, :danger]
      display = Settings.tour.displays.hide
    end

    link_to t(".#{text[0]}"),
            admin_tour_path(tour.id,
                            {tour: {display: display}}),
            method: :patch, data: {confirm: t(".confirm")},
            class: "link-#{text[1]}"
  end

  def select_options_for_booking
    Booking.statuses.map{|k, v| [t(".#{k}"), v]}
  end
end
