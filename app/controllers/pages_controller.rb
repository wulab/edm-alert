class PagesController < ApplicationController
  def index
    @events = Event.all.this_weeks.most_recent(50)
    @hash = build_markers(@events)
  end

  def map
    @events = Event.all.this_weeks.most_recent(50)
    @event_provinces = Location.joins(:events).pluck(:province).uniq
    @event_categories = Event.categories.keys
    @hash = build_markers(@events)
  end

  def map_with_location
    @events = Event.joins(:location).
                where(locations: { province: params[:location] }).
                order(start_at: :desc).this_weeks.most_recent(20)
    @event_provinces = Location.joins(:events).
                        pluck(:province).uniq - [params[:location]]
    @event_categories = Event.categories.keys
    @hash = build_markers(@events)
    render :map
  end

  def map_with_category
    @events = Event.where(category: params[:category]).
                order(start_at: :desc).this_weeks.most_recent(20)
    @event_provinces = Location.joins(:events).pluck(:province).uniq
    @event_categories = Event.categories.keys - [params[:category]]
    @hash = build_markers(@events)
    render :map
  end

  private

  def build_markers(events)
    Gmaps4rails.build_markers(events) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
      marker.title event.title
      marker.infowindow render_to_string(
        partial: "/events/infowindow",
        locals: { event_title: event.title,
          event_url: event_path(event),
          event_date: event.start_at.strftime("วันที่: %-d/%-m/%y เวลา %H:%M")}
      )
      marker.json({
        clickable: true,
        center: [event.latitude, event.longitude]
      })
      marker.picture({
        width:  32,
        height: 37,
        anchor: [10, 10],
        url:    view_context.image_path("#{event.category}.png")
      })
    end
  end
end
