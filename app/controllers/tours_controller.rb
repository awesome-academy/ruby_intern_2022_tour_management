class ToursController < ApplicationController
  def show
    @tour = Tour.find_by id: params[:id]

    return if @tour.present?

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
