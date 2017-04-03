require 'rails_helper'

describe PagesController do
  describe "GET #map" do
    it "shows latest events" do
      get :map

      expect(response).to be_success
    end
  end

  describe "GET #map_with_location" do
    it "shows events in location area" do
      location = build(:location)
      event = create(:event, location: location)
      get :map_with_location, params: { location: location.province }

      expect(response).to be_success
    end
  end

  describe "GET #map_with_category" do
    it "shows events in category" do
      location = build(:location)
      event = create(:event, location: location, category: "earthquake")
      get :map_with_category, params: { category: event.category }

      expect(response).to be_success
    end
  end
end
