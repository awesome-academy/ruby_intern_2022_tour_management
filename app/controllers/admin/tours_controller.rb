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

  def show
    return if @tour.present?

    flash[:danger] = t ".not_found"
    redirect_to admin_root_path
  end

  def edit; end

  def update
    if @tour.update tour_params
      flash[:success] = t ".passed"
      redirect_to admin_tour_path(@tour.id)
    else
      flash.now[:danger] = t ".failed"
      render :edit
    end
  end

  def destroy
    if @tour.update active: false
      flash[:success] = t ".passed"
    else
      flash[:danger] = t ".failed"
    end
    redirect_to admin_root_path
  end

  private

  def find_tour_by_id
    @tour = Tour.find params[:id]
  end

  def tour_params
    params.require(:tour).permit(Tour::CREATE_ATTRS)
  end
end
