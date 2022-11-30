require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  describe "GET #index" do
    before do
      get :index
      sleep 1
    end

    it "shoud have ok status" do
      expect(response).to have_http_status 200
    end

    it "should render template" do
      expect(response).to render_template "static_pages/index"
    end
  end
end
