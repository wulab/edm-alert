class FloodDataCollectionJob < ApplicationJob
  queue_as :default

  def perform(*args)
    uri = URI('http://203.155.220.119/DDS_Flooding/')
    logger.debug "request=#{uri}"

    response = Net::HTTP.get_response(uri)
    logger.debug "Response"
    logger.debug "status=#{response.code} body=#{response.body[0,200]}"

    document = Nokogiri::HTML(response.body)
    document.css("table.gridtable tr")[3..-1].each do |row|
      title    = "น้ำท่วมขังบริเวณ #{row.css('td')[3].content.strip}"
      district = row.css('td')[1].content.strip
      location = Location.find_by(district: district)

      unless location.present?
        logger.debug "! Skipped #{title}"
        next
      end

      event = Event.create_with(
        category:    'flood',
        latitude:    location.latitude,
        location:    location,
        longitude:   location.longitude,
        source_name: 'สำนักการระบายน้ำ',
        source_url:  'http://203.155.220.119/DDS_Flooding/',
        source_data: {
          content: row.to_html,
          content_type: 'html'
        }
      ).find_or_create_by(
        title:    title,
        start_at: ActiveSupport::TimeZone['Bangkok'].parse(row.css('td')[7].content.strip)
      )

      if event.invalid?
        logger.debug "! Failed to create event #{event.title}"
        logger.debug "  errors=#{event.errors.messages}"
      end
    end
  end
end
