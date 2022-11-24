require "rails_helper"

RSpec.describe TourSchedulesController, type: :controller do
  let(:user){ FactoryBot.create :user, role: User.roles[:normal] }
  let(:tour){ FactoryBot.create :tour }
  let(:tour_schedule){ FactoryBot.create :tour_schedule, tour_id: tour.id }
  
  describe "GET #show" do
    context "when have tour schedule" do
      before do
        get :show, params: {id: tour.id}
        sleep 1
      end

      it "should have ok status" do
        expect(response).to have_http_status 200
      end

      it "should render template" do
        expect(response).to render_template "tour_schedules/show"
      end
    end
  end
end
