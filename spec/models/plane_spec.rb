require "rails_helper"

RSpec.describe Plane, type: :model do
  let!(:plane) {FactoryBot.create :plane}
  describe "Validations" do
    context "when all required fields given" do
      it "should be true" do
        expect(plane.valid?).to eq true
      end
    end
  end

  describe "Associations" do
    it "should has many requests" do
      is_expected.to have_many(:requests).dependent(:destroy)
    end

    it "should has many locations" do
      is_expected.to have_many(:locations).through(:requests)
    end
  end
end
