json.data do
  json.location do
    json.id          @location.id
    json.district    @location.district
    json.province    @location.province
    json.postal_code @location.postal_code
    json.coordinate do
      json.latitude  @location.latitude
      json.longitude @location.longitude
    end
  end
end
