require "rails_helper"

RSpec.describe Job, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:analyses).dependent(:destroy) }
  end

  describe "validations" do
    subject(:job) { build(:job) }

    it "is valid with valid attributes" do
      expect(job).to be_valid
    end

    it "requires a company" do
      job.company = nil

      expect(job).not_to be_valid
    end

    it "requires a title" do
      job.title = nil

      expect(job).not_to be_valid
    end

    it "requires a description" do
      job.description = nil

      expect(job).not_to be_valid
    end
  end
end
