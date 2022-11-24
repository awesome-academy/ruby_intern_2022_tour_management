require "rails_helper"

RSpec.describe Admin::BookingsController, type: :controller do
  let(:user){ FactoryBot.create :user }

  before do
    sign_in user
  end

  describe "GET #index" do
    before do
      get :index
      sleep 1
    end

    it "should return OK status" do
      expect(response).to have_http_status 200
    end

    it "should render booking index template" do
      expect(response).to render_template "admin/bookings/index"
    end

    context "when have chart params" do
      subject { get :index, params:{chart: Settings.chart.booking_status.params} }

      it "shoud have OK status" do
        expect(subject).to have_http_status 200
      end

      it "should show template" do
        expect(subject).to render_template "admin/bookings/chart_status"
      end
    end

  end

  describe "PATCH #update" do
    let!(:user2){ FactoryBot.create :user, email: "example1@gmail.com" }
    let!(:tour){ FactoryBot.create :tour }
    let!(:tour_schedule){ FactoryBot.create :tour_schedule,
                                            tour_id: tour.id }
    let(:booking){ FactoryBot.create :booking, user_id: user2.id, tour_schedule_id: tour_schedule.id }

    before do
      patch :update, params:{ id: booking.id,
                             status: Booking.statuses[:accept] }
      sleep 1
    end

    it "should return found status" do
      expect(response).to have_http_status 302
    end

    it "should redriect to booking index template" do
      expect(response).to redirect_to admin_bookings_path
    end
  end
end
