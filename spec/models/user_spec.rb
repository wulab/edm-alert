require 'rails_helper'

describe User, type: :model do
  context "associations" do
    it { should belong_to(:location) }
  end

  context "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:postal_code) }
  end

  context "#user" do
    it "creates a new account" do
      location = build(:location)
      user = create(:user, full_name: "full name", location: location)
      expect(user.email).to be_present
      expect(user.full_name).to eq "full name"
    end

    it "has a postal code" do
      location = build(:location)
      user = build(:user, location: location)
      expect(user.postal_code).to eq(location.postal_code)
    end
  end
end
