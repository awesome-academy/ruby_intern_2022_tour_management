class Admin::ToursController < Admin::BaseController
  def show
    @tour = Tour.find_by id: params[:id]

    return if @tour.present?

    flash[:danger] = t ".not_found"
    redirect_to admin_root_path
  end
end
