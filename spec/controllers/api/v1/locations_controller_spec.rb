require 'rails_helper'

describe Api::V1::LocationsController do
  describe "GET #show" do
    render_views
    it "with valid location and returns a 200" do
      location = create(:location)
      get :show, params: { id: location.postal_code }, format: :json

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['data']['location']['postal_code'])
        .to eq(location.postal_code)
    end

    it "with invalid location and returns a 404" do
      get :show, params: { id: 1 }, format: :json

      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)['data']['message']).to eq('Not Found')
    end
  end
end
