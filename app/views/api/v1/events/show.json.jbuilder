json.data do
  json.event do
    json.id @event.id
    json.location @event.location.province
    json.title @event.title
    json.category t("categories.#{@event.category}")
    json.source_name @event.source_name
    json.source_url @event.source_url
  end
end
