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
    tour_id.nil? ? new_admin_tour_path : admin_tour_path(tour_id)
  end

  def tour_images
    @tour.images.includes(:blob)
  end

  def get_root_path
    current_user&.admin? ? admin_root_path : root_path
  end
end
