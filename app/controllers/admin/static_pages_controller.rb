class Admin::StaticPagesController < Admin::BaseController
  def index
    @pagy, @tours = pagy Tour.time_desc
  end
end
