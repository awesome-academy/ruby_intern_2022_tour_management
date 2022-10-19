class StaticPagesController < ApplicationController
  before_action :get_tours, only: :index

  def index; end
end
