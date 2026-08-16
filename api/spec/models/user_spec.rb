require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:jobs).dependent(:destroy) }
    it { is_expected.to have_many(:resumes).dependent(:destroy) }
  end

  describe "validations" do
    subject(:user) { build(:user) }

    it "is valid with a valid email" do
      expect(user).to be_valid
    end

    it "requires an email" do
      user.email = nil

      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end
  end
end
