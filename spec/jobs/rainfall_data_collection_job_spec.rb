require 'rails_helper'

describe RainfallDataCollectionJob do
  context "perform" do
    it "creates new events with location" do
      location = build(:location)
      allow(Location).to receive(:find_by).and_return(location)
      VCR.use_cassette("thaiwater") do
        RainfallDataCollectionJob.perform_now
      end

      expect(Event.count).to_not eq(0)
    end

    it "not creates new events without location" do
      VCR.use_cassette("thaiwater") do
        RainfallDataCollectionJob.perform_now
      end

      expect(Event.count).to eq(0)
    end
  end
end
