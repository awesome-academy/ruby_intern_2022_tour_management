require "rails_helper"

RSpec.describe BookingsController, type: :controller do
  let(:user){ FactoryBot.create :user, role: User.roles[:normal] }
  let(:tour){ FactoryBot.create :tour }
  let(:tour_schedule){ FactoryBot.create :tour_schedule, tour_id: tour.id }

  before do
    sign_in user
  end

  describe "POST #create" do
    context "when success create" do
      before do
        post :create, params: {id: tour_schedule.id}
        sleep 1
      end

      it "should have found status" do
        expect(response).to  have_http_status 302
      end

      it "should redirect template" do
        expect(response).to  redirect_to bookings_path
      end

      it "should have success flash" do
        expect(flash[:success]).to eql I18n.t(".bookings.create.booking_success")
      end
    end

    context "when fail create" do
      before do
        post :create, params: {id: tour_schedule.id+1}
        sleep 1
      end

      it "should have found status" do
        expect(response).to have_http_status 302
      end

      it "should redirect template" do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET #show" do
    context "when have booking" do
      before do
        get :show
      end

      it "should have ok status" do
        expect(response).to have_http_status 200
      end

      it "should render template" do
        expect(response).to render_template "bookings/show"
      end
    end
  end

  describe "DELETE #destroy" do
    let(:booking){ FactoryBot.create :booking, user_id: user.id,
                                      tour_schedule_id: tour_schedule.id }

    before do
      delete :destroy, params:{id: booking.id}
      sleep 1
    end

    context "when success delete" do
      it "should have found status" do
        expect(response).to have_http_status 302
      end

      it "should redirect template" do
        expect(response).to redirect_to bookings_path
      end

      it "should show success flash" do
        expect(flash[:success]).to eql I18n.t(".bookings.destroy.success_destroy")
      end
    end

    context "when fail delete" do
      let(:booking2){ FactoryBot.create :booking, status: Booking.statuses[:accept],
                                        user_id: user.id, tour_schedule_id: tour_schedule.id }

      before do
        delete :destroy, params:{id: booking2.id}
      end

      it "should have found status" do
        expect(response).to have_http_status 302
      end

      it "should redirect template" do
        expect(response).to redirect_to bookings_path
      end

      it "should show info flash" do
        expect(flash[:info]).to eql I18n.t(".bookings.destroy.not_destroy")
      end
    end
  end
end
