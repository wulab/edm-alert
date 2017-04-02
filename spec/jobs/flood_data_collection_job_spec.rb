require 'rails_helper'

describe FloodDataCollectionJob do
  context "perform" do
    it "creates new events match with a location" do
      location = build(:location)
      allow(Location).to receive(:find_by).and_return(location)
      VCR.use_cassette("DDS_flooding") do
        FloodDataCollectionJob.perform_now
      end

      expect(Event.count).to_not eq(0)
    end

    it "not creates new events not match with a location" do
      VCR.use_cassette("DDS_flooding") do
        FloodDataCollectionJob.perform_now
      end

      expect(Event.count).to eq(0)
    end
  end
end
