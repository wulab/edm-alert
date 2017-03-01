json.data do
  json.event do
    json.id          @event.id
    json.location    @event.location.province
    json.postal_code @event.location.postal_code
    json.title       @event.title
    json.category    t("categories.#{@event.category}")
    json.source_name @event.source_name
    json.source_url  @event.source_url
    json.date        date_format(@event.start_at)
    json.date_raw    @event.start_at
    json.coordinate do
      json.latitude  @event.location.latitude
      json.longitude @event.location.longitude
    end
  end
end
