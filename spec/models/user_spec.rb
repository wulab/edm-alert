require 'rails_helper'

describe User, type: :model do
  context "associations" do
    it { should belong_to(:location) }
  end

  context "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:full_name) }
  end

  context "#user" do
    it "creates a new user" do
      user = build(:user)
      user.full_name = "full name"
      user.save

      expect(user.email).to be_present
      expect(user.full_name).to eq "full name"
    end
  end
end
