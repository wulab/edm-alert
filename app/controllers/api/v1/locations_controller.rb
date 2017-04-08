class Api::V1::LocationsController < ApplicationController
  before_action :set_headers

  def show
    if @location = Location.find_by(postal_code: params[:id])
      render :show, status: :ok
    else
      render json: { data: { message: "Not Found" } }
    end
  end

  private

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
