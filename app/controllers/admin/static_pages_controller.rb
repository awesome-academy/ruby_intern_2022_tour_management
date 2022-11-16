class Admin::StaticPagesController < Admin::BaseController
  def index
    @q = Tour.ransack params[:q]
    @pagy, @tours = pagy @q.result(distinct: true),
                         items: Settings.pagy.tour.admin.number
  end
end
