class Api::V1::ToursController < Api::V1::ApplicationController
  before_action :get_tours, only: :index

  def index
    render json: @tours
  end
end
