class EarthquakeDataCollectionJob < ApplicationJob
  queue_as :default

  # @example
  #
  # <DailySeismicEvents version="1.0">
  #   <header>
  #     <title>Daily Seismic (Earthquake) Events in Region and global</title>
  #     <description>Daily Seismic (Earthquake) Events in Region and global</description>
  #     <uri>http://data.tmd.go.th/api/DailySeismicEvent/v1/index.php</uri>
  #     <lastBuildDate>2016-10-08 20:33:06</lastBuildDate>
  #     <copyRight>Thai Meteorological Department:2558</copyRight>
  #     <generator>TMDData_API Services</generator>
  #     <status>200 OK</status>
  #   </header>
  #   <DailyEarthquakes>
  #     <OriginThai>อ.สะเมิง จ.เชียงใหม่</OriginThai>
  #     <OriginEnglish>Amphoe Samoeng , Chiang Mai</OriginEnglish>
  #     <DateTimeUTC>2016-10-07 20:34:37.000</DateTimeUTC>
  #     <DateTimeThai>2016-10-08 03:34:37.000</DateTimeThai>
  #     <Depth unit="km.">6</Depth>
  #     <Magnitude>3.2</Magnitude>
  #     <Latitude>18.9400000</Latitude>
  #     <Longitude>98.7000000</Longitude>
  #     <TitleThai>แผ่นดินไหวที่ อ.สะเมิง จ.เชียงใหม่</TitleThai>
  #     <TitleEnglish>Earthquake at Amphoe Samoeng , Chiang Mai</TitleEnglish>
  #   </DailyEarthquakes>
  def perform(*args)
    uri = URI('http://data.tmd.go.th/api/DailySeismicEvent/v1/?uid=api&ukey=api12345')
    logger.debug "request=#{uri}"

    response = Net::HTTP.get_response(uri)
    logger.debug "Response"
    logger.debug "status=#{response.code} body=#{response.body[0,200]}"

    document    = Hash.from_xml(response.body)
    earthquakes = document['DailySeismicEvents']['DailyEarthquakes']
    earthquakes.each do |earthquake|
      m = /อ\.(\S+) จ\.(\S+)/.match(earthquake['OriginThai'])

      unless m.present?
        logger.debug "! Skipped #{earthquake['TitleThai']}"
        next
      end

      location = Location.find_by(district: m[1], province: m[2])

      unless location.present?
        logger.debug "! Skipped #{earthquake['TitleThai']}"
        next
      end

      event = Event.create_with(
        category:    'earthquake',
        latitude:    earthquake['Latitude'],
        location:    location,
        longitude:   earthquake['Longitude'],
        source_name: 'กรมอุตุนิยมวิทยา',
        source_url:  uri.to_s,
        source_data: {
          content: earthquake,
          content_type: 'json'
        }
      ).find_or_create_by(
        title:    earthquake['TitleThai'],
        start_at: earthquake['DateTimeUTC']
      )

      if event.invalid?
        logger.debug "! Failed to create event #{event.title}"
        logger.debug "  errors=#{event.errors.messages}"
      end
    end
  end
end
