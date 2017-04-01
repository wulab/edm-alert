require 'rails_helper'

describe Event, type: :model do
  context "associations" do
    it { should belong_to(:location) }
    it { should have_many(:users) }
  end

  context "#event" do
    it "creates a new event" do
      location = build(:location)
      event = create(:event, location: location)
      expect(event.title).to be_present
    end
  end
end
