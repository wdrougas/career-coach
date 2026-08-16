require "rails_helper"

RSpec.describe Resume, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:analyses).dependent(:destroy) }
  end

  describe "validations" do
    subject(:resume) { build(:resume) }

    it "is valid with valid attributes" do
      expect(resume).to be_valid
    end

    it "requires a title" do
      resume.title = nil

      expect(resume).not_to be_valid
      expect(resume.errors[:title]).to include("can't be blank")
    end
  end
end
