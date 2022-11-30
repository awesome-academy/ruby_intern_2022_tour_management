require "rails_helper"

RSpec.describe ReviewsController, type: :controller do
  let(:user){ FactoryBot.create :user, role: 0 }
  let(:tour){ FactoryBot.create :tour }

  describe "POST #create" do
    before do
      sign_in user
      post :create, params: {
                      review:{
                        comment: "new comment",
                        tour_id: tour.id
                      }
                    },
           format: "js"
    end

    it "should have ok status" do
      expect(response).to have_http_status 200
    end
  end
end
