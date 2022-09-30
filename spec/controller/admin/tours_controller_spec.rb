require "rails_helper"
include SessionsHelper

RSpec.shared_examples "update examples" do
  it "should found" do
    expect(response).to  have_http_status 302
  end

  it "should show success flash" do
    expect(flash[:success]).to  eql I18n.t(".admin.tours.update.passed")
  end
end

RSpec.describe Admin::ToursController, type: :controller do
  let(:tour){ FactoryBot.create :tour }
  let(:user){ FactoryBot.create :user }

  before do
    log_in user
  end

  describe "GET #show" do
    context "when found tour" do
      before do
        get :show, params: {id: tour.id}
        sleep 1
      end

      it "assigns @tour" do
        expect(assigns(:tour)).to eql (tour)
      end

      it "return a success response" do
        expect(response).to have_http_status(200)
      end

      it "render show template" do
        expect(response).to render_template "admin/tours/show"
      end
    end

    context "when not found tour" do
      before do
        get :show, params: {id: 2}
        sleep 1
      end

      it "return a found status" do
        expect(response).to have_http_status(302)
      end

      it "redirect to admin root path" do
        expect(response).to redirect_to admin_root_path
      end

      it "show flash danger" do
        expect(flash[:danger]).to eql I18n.t("admin.tours.show.not_found")
      end
    end
  end

  describe "GET #new"do
    context "when get new tour" do
      before do
        get :new
      end
      it "return a OK status" do
        expect(response).to have_http_status(200)
      end

      it "render a new template" do
        expect(response).to render_template "admin/tours/new"
      end
    end
  end

  describe "POST #create" do
    context "when successful create" do
      before do
        allow_any_instance_of(Tour).to receive(:validate_image).and_return(true)

        post :create, params: {tour: FactoryBot.build(:tour).attributes}
        sleep 1
      end

      it "return a found status" do
        expect(response).to have_http_status(302)
      end

      it "redirect to book" do
        expect(response).to redirect_to admin_tour_path(Tour.last.id)
      end

      it "show flash success" do
        expect(flash[:success]).to eql I18n.t(".admin.tours.create.success_save")
      end
    end

    context "when fail create" do
      before do
        post :create, params: {tour: FactoryBot.build(:tour).attributes}
      end

      it "return a OK status" do
        expect(response).to have_http_status(200)
      end

      it "show danger flash" do
        expect(flash[:danger]).to eql I18n.t(".admin.tours.create.unsuccess_save")
      end

      it "render new template" do
        expect(response).to render_template "admin/tours/new"
      end
    end
  end

  describe "DELETER #destroy" do
    context "when successful delete" do
      before do
        allow_any_instance_of(Tour).to receive(:has_bookings?).and_return false
        delete :destroy, params: {id: tour.id}
        sleep 1
      end

      it "shold show flash success" do
        expect(flash[:success]).to eql I18n.t(".admin.tours.destroy.success_destroy")
      end

      it "should redirect to admin page" do
        expect(response).to redirect_to admin_root_path
      end

      it "should found" do
        expect(response).to have_http_status 302
      end
    end

    context "when tour have booking" do
      before do
        allow_any_instance_of(Tour).to receive(:has_bookings?).and_return true
        delete :destroy, params: {id: tour.id}
        sleep 1
      end

      it "should have found status" do
        expect(response).to have_http_status 302
      end

      it "should show danger flash" do
        expect(flash[:danger]).to eql I18n.t(".admin.tours.destroy.not_destroy")
      end

      it "should redirect to admin home page" do
        expect(response).to redirect_to admin_root_path
      end
    end

    context "when fail delete booking" do
      before do
        allow_any_instance_of(Tour).to receive(:destroy).and_return false
        delete :destroy, params: {id: tour.id}
        sleep 1
      end

      it "should show danger flash" do
        expect(flash[:danger]).to eql I18n.t(".admin.tours.destroy.fail_destroy")
      end

      it "should found status" do
        expect(response).to have_http_status 302
      end
    end
  end

  describe "PATCH #update" do
    context "when success update tour" do
      before do
        patch :update, params: {
          id: tour.id,
          tour: {title: "new title", description: "new desciption"}
        }
        sleep 1
      end

      include_examples "update examples"
      it "should redirect to admin tour" do
        expect(response).to redirect_to admin_tour_path(tour.id)
      end
    end

    context "when fail update tour" do
      before do
        allow_any_instance_of(Tour).to receive(:update).and_return false
        patch :update, params: {
          id: tour.id,
          tour: {title: "new title", description: "new description"}
        }
        sleep 1
      end

      it "should return ok status" do
        expect(response).to have_http_status 200
      end

      it "should render edit template" do
        expect(response).to render_template "admin/tours/edit"
      end

      it "should show danger flash" do
        expect(flash[:danger]).to eql I18n.t(".admin.tours.update.failed")
      end
    end

    context "when change tour active" do
      before do
        tour.update active: Settings.tour.displays.hide
        patch :update, params:{
          id: tour.id,
          tour: {display: Settings.tour.displays.show}
        }
        sleep 1
      end

      it_behaves_like "update examples"

      it "should redirect to admin home" do
        expect(response).to redirect_to admin_root_path
      end
    end
  end
end
