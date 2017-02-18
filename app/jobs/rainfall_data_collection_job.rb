class RainfallDataCollectionJob < ApplicationJob
  queue_as :default

  # @example

  # {
  #   "type": "FeatureCollection",
  #   "features": [{
  #       "geometry": {
  #           "type": "Point",
  #           "coordinates": [
  #               101.52,
  #               6.38511
  #           ]
  #       },
  #       "type": "Feature",
  #       "properties": {
  #           "province_code": 96,
  #           "province_name": "นราธิวาส",
  #           "time": "17:00",
  #           "rainfall": "20.4",
  #           "label": "สวนสาธารณะเทศบาลตำบลรือเสาะ (STH022)<br>จ.นราธิวาส อ.รือเสาะ<br>ฝน 24 ชม  20.4 มม. เวลา 17:00",
  #           "popupContent": "<strong>สวนสาธารณะเทศบาลตำบลรือเสาะ (STH022)</strong><br>จ.นราธิวาส  อ.รือเสาะ ต.รือเสาะ<br>ฝน 24 ชม  20.4 มม. เวลา 17:00 <a href='http://wea.haii.or.th/graph/zcgraph.php?code=STH022&type=rain24h&schema=south31' data-toggle='lightbox' title='กราฟแสดงฝนรายชั่วโมง'><i class='fa fa-bar-chart'></i></a>"
  #       },
  #       "id": "STH022"
  #   }
  def perform(*args)
    uri = URI('http://www.thaiwater.net/v3/geojson/rainfall24h')
    logger.debug "request=#{uri}"

    response = Net::HTTP.get_response(uri)
    logger.debug "Response"
    logger.debug "status=#{response.code} body=#{response.body[0,200]}"

    document  = JSON.parse(response.body)
    rainfalls = document['features']
    rainfalls.each do |rainfall|
      fields  = rainfall['properties']['label'].split('<br>')
      title   = "ฝนตกหนักที่ #{fields[0][/[^(]+/].strip}"
      address = fields[1]

      mm = Float(rainfall['properties']['rainfall'])
      if mm > 10.0
        logger.debug "! Skipped #{title}"
        next
      end

      m = /จ\.(\S+) อ\.(\S+)/.match(address)
      unless m.present?
        logger.debug "! Skipped #{title}"
        next
      end

      location = Location.find_by(district: m[2], province: m[1])
      unless location.present?
        logger.debug "! Skipped #{title}"
        next
      end

      event = Event.create_with(
        category:    'rainfall',
        latitude:    rainfall['geometry']['coordinates'][1],
        location:    location,
        longitude:   rainfall['geometry']['coordinates'][0],
        source_name: 'สถาบันสารสนเทศทรัพยากรน้ําและการเกษตร',
        source_url:  uri.to_s,
        source_data: {
          content:      rainfall,
          content_type: 'json'
        }
      ).find_or_create_by(
        title:    title,
        start_at: ActiveSupport::TimeZone['Bangkok'].parse(rainfall['properties']['time'])
      )

      if event.invalid?
        logger.debug "! Failed to create event #{event.title}"
        logger.debug "  errors=#{event.errors.messages}"
      end
    end
  end
end
