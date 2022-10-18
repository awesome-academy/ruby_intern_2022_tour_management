module ApplicationHelper
  include Pagy::Frontend

  def get_path
    params[:controller] == "admin/static_pages" ? admin_root_path : root_path
  end

  def get_reviews tour
    tour.reviews.includes(:user)
  end
end
