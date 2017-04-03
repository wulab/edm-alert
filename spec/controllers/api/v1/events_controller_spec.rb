require 'rails_helper'

describe Api::V1::EventsController do
  describe "GET #index" do
    it "returns a 200" do
      get :index, format: :json

      expect(response.status).to eq(200)
    end
  end

  describe "GET #show" do
    it "returns a 200" do
      location = build(:location)
      event = create(:event, location: location)
      get :show, params: { id: event.id }, format: :json

      expect(response.status).to eq(200)
    end
  end

  describe "GET #category" do
    it "returns a 200" do
      location = build(:location)
      event = create(:event, location: location, category: "earthquake")
      get :category, params: { category: event.category }, format: :json

      expect(response.status).to eq(200)
    end

    it "with 'แผ่นดินไหว' category name and returns a 200" do
      location = build(:location)
      event = create(:event, location: location, category: "earthquake")
      get :category, params: { category: "แผ่นดินไหว" }, format: :json

      expect(response.status).to eq(200)
    end

    it "with 'น้ำท่วม' category name and returns a 200" do
      location = build(:location)
      event = create(:event, location: location, category: "flood")
      get :category, params: { category: "น้ำท่วม" }, format: :json

      expect(response.status).to eq(200)
    end

    it "with 'ฝนตกหนัก' category name and returns a 200" do
      location = build(:location)
      event = create(:event, location: location, category: "rainfall")
      get :category, params: { category: "ฝนตกหนัก" }, format: :json

      expect(response.status).to eq(200)
    end

    it "with 'ฝนตก' category name and returns a 200" do
      location = build(:location)
      event = create(:event, location: location, category: "rainfall")
      get :category, params: { category: "ฝนตก" }, format: :json

      expect(response.status).to eq(200)
    end
  end

  describe "GET #location" do
    it "returns a 200" do
      location = build(:location)
      event = create(:event, location: location)
      get :location, params: { location: location.province }, format: :json

      expect(response.status).to eq(200)
    end
  end

  describe "GET #postalcode" do
    it "returns a 200" do
      location = build(:location)
      event = create(:event, location: location)
      get :postalcode, params: { postalcode: location.postal_code }, format: :json

      expect(response.status).to eq(200)
    end
  end
end
