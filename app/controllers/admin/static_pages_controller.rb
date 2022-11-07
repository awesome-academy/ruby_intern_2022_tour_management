class Admin::StaticPagesController < Admin::BaseController
  def index
    @pagy, @tours = pagy Tour.time_desc.by_title(params[:title])
                             .actived(params[:active]),
                         items: Settings.pagy.tour.admin.number
  end
end
