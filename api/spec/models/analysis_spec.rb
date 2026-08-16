require "rails_helper"

RSpec.describe Analysis, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:resume) }
    it { is_expected.to belong_to(:job) }
  end

  describe "validations" do
    subject(:analysis) { build(:analysis) }

    it "is valid with valid attributes" do
      expect(analysis).to be_valid
    end

    it "requires a resume" do
      analysis.resume = nil

      expect(analysis).not_to be_valid
      expect(analysis.errors[:resume]).to include("must exist")
    end

    it "requires a job" do
      analysis.job = nil

      expect(analysis).not_to be_valid
      expect(analysis.errors[:job]).to include("must exist")
    end
  end
end
