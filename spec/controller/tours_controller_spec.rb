require "rails_helper"

RSpec.describe ToursController, type: :controller do
  let(:user){ FactoryBot.create :user, role: User.roles[:normal] }

  describe "GET #show" do
    context "when don't have tour" do
      before do
        get :show, params: { id: 1 }
        sleep 1
      end

      it "should have 302 status" do
        expect(response).to have_http_status 302
      end

      it "should redirect template" do
        expect(response).to redirect_to root_path
      end

      it "should show flash" do
        expect(flash[:danger]).to eql I18n.t(".tours.show.not_found")
      end
    end

    context "when have tour" do
      let(:tour){FactoryBot.create :tour, active: true}

      before do
        get :show, params:{ id: tour.id }
        sleep 1
      end

      it "should have ok status" do
        expect(response).to  have_http_status 200
      end

      it "should render template" do
        expect(response).to render_template "tours/show"
      end
    end
  end
end
