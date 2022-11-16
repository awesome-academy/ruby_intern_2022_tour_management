require "rails_helper"

RSpec.shared_examples "show index page" do
  it "should return OK status" do
    expect(response).to have_http_status 200
  end

  it "should render index template" do
    expect(response).to render_template "admin/static_pages/index"
  end
end

RSpec.describe Admin::StaticPagesController, type: :controller do
  let(:user){ FactoryBot.create :user }

  before do
    sign_in user
  end

  describe "GET #index" do
    context "when have tour" do
      let!(:tour){ FactoryBot.create :tour, active: true}

      before do
        get :index
        sleep 1
      end

      it_behaves_like "show index page"
    end

    context "when don't have tour" do
      before do
        get :index
        sleep 1
      end

      it_behaves_like "show index page"
    end

  end
end
