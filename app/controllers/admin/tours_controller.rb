class Admin::ToursController < Admin::BaseController
  def new
    @tour = Tour.new
    @tour.tour_schedules.build
  end

  def create
    @tour = Tour.new tour_params

    if @tour.save
      flash[:success] = t ".success_save"
      redirect_to new_admin_tour_path
    else
      flash.now[:danger] = t ".unsuccess_save"
      render :new
    end
  end

  def show
    @tour = Tour.find_by id: params[:id]

    return if @tour.present?

    flash[:danger] = t ".not_found"
    redirect_to admin_root_path
  end

  private

  def tour_params
    params.require(:tour).permit(Tour::CREATE_ATTRS)
  end
end
