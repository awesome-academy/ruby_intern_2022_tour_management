require "rails_helper"

RSpec.describe Tour, type: :model do
  describe "Valid tour" do
    subject{FactoryBot.build :tour}

    it "should tour is valid" do
      expect(subject).to be_valid
    end
  end

  describe "Validates" do
    it {is_expected.to validate_presence_of(:title)}
    it {is_expected.to validate_length_of(:title)}
    it {is_expected.to validate_presence_of(:description)}
    it {is_expected.to validate_length_of(:description)}
    it "with invalid number of images" do
      tour = Tour.create title: "tour title", description: "tour description", active: true
      expect(tour.errors[:images]).to eq(
        ["#{I18n.t('.images_count_error')} #{Settings.images.total_min}"]
      )
    end
  end

  describe "#show_active" do
    let!(:tour){FactoryBot.create :tour}

    before do
      sleep 1
    end

    context "when tour active" do
      it "should return a 'yes' text" do
        tour.update active: true

        expect(tour.show_active).to eql I18n.t(".true")
      end
    end

    context "when tour not active" do
      it "should return a 'no' text" do
        tour.update active: false

        expect(tour.show_active).to eql I18n.t(".false")
      end
    end
  end

  describe "#has_bookings?" do
    let!(:tour){FactoryBot.create :tour}
    let(:user){FactoryBot.create :user}
    let(:tour_schedule){FactoryBot.create :tour_schedule, tour_id: tour.id}

    before do
      sleep 1
    end

    it "should return true when tour has bookings" do
      FactoryBot.create(:booking, user_id: user.id,
                        tour_schedule_id: tour_schedule.id)
      expect(tour.has_bookings?).to eq true
    end

    it "should return false when tour don't has any bookings" do
      expect(tour.has_bookings?).to eq false
    end
  end

  describe "check scope" do
    let!(:tour_1){FactoryBot.create :tour}
    let!(:tour_2){FactoryBot.create :tour}

    before do
      sleep 1
    end

    context "when order by updated_at descending" do
      it "should order by updated_at" do
        expect(Tour.time_desc).to eq [tour_2, tour_1]
      end
    end

    context "when find tour by id" do
      it "should return tour 1" do
        expect(Tour.by_id tour_1.id).to eq [tour_1]
      end
    end

    context "when find tour by title" do
      it "should return tour 1" do
        expect(Tour.by_title tour_1.title).to eq [tour_1]
      end
    end

    context "when find tour by active" do
      it "should return tour 1" do
        tour_1.update active: true
        tour_2.update active: false

        expect(Tour.actived tour_1.active).to eq [tour_1]
      end
    end
  end
end
