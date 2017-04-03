require 'rails_helper'

describe EventsController do
  describe "GET #show" do
    it "shows latest events" do
      location = build(:location)
      event = build(:event, location: location)
      get :index

      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "shows specific event" do
      location = build(:location)
      event = create(:event, location: location)
      get :show, params: { id: event.id }

      expect(response).to be_success
    end
  end

  describe "GET #category" do
    it "shows events in category" do
      location = build(:location)
      event = build(:event, location: location)
      get :category, params: { category: "earthquake" }

      expect(response).to be_success
    end
  end

  describe "GET #location" do
    it "shows events in location area" do
      location = build(:location)
      event = build(:event, location: location)
      get :location, params: { location: "เชียงใหม่" }

      expect(response).to be_success
    end
  end

  describe "GET #postalcode" do
    it "shows event in postal code area" do
      location = build(:location)
      event = build(:event, location: location)
      get :postalcode, params: { postalcode: "10400" }

      expect(response).to be_success
    end
  end
end
