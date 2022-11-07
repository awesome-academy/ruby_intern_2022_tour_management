class Admin::ToursController < Admin::BaseController
  before_action :find_tour_by_id, except: %i(new create)

  def new
    @tour = Tour.new
    @tour.tour_schedules.build
  end

  def create
    @tour = Tour.new tour_params

    if @tour.save
      flash[:success] = t ".success_save"
      redirect_to admin_tour_path(@tour.id)
    else
      flash.now[:danger] = t ".unsuccess_save"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @tour.update tour_params
      flash[:success] = t ".passed"
      redirect_after_update
    else
      flash.now[:danger] = t ".failed"
      render :edit
    end
  end

  def destroy
    if @tour.has_bookings?
      flash[:danger] = t ".not_destroy"
    elsif @tour.destroy
      flash[:success] = t ".success_destroy"
    else
      flash[:danger] = t ".fail_destroy"
    end
    redirect_to admin_root_path
  end

  private

  def redirect_after_update
    if params[:tour][:display].present?
      redirect_to admin_root_path
    else
      redirect_to admin_tour_path(@tour.id)
    end
  end

  def find_tour_by_id
    @tour = Tour.find params[:id]
  end

  def tour_params
    tour_params = params.require(:tour).permit(Tour::CREATE_ATTRS)

    if params[:tour][:display].present?
      tour_params[:active] = params[:tour][:display]
    end

    tour_params
  end
end
