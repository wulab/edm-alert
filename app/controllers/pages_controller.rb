class PagesController < ApplicationController
  def index
    @events = Event.all.this_weeks
    @hash = Gmaps4rails.build_markers(@events) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
      marker.title event.title
      marker.infowindow event.title
      marker.json({
        :clickable => true,
        :center => [event.latitude, event.longitude]
      })
      marker.picture({
        :width   => 32,
        :height  => 37,
        :anchor  => [10, 10],
        :url     => view_context.image_path("#{event.category}.png")
      })
    end
  end

  def map
    @events = Event.all.this_weeks.most_recent(100)
    @event_provinces = Location.joins(:events).pluck(:province).uniq
    @event_categories = Event.categories.keys
    @hash = Gmaps4rails.build_markers(@events) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
      marker.title event.title
      marker.infowindow event.title
      marker.json({
        :clickable => true,
        :center => [event.latitude, event.longitude]
      })
      marker.picture({
        :width   => 32,
        :height  => 37,
        :anchor  => [10, 10],
        :url     => view_context.image_path("#{event.category}.png")
      })
    end
  end

  def map_with_location
    @events = Event.joins(:location).where(locations: { province: params[:location] }).order(start_at: :desc).this_weeks.most_recent(20)
    @event_provinces = Location.joins(:events).pluck(:province).uniq
    @event_categories = Event.categories.keys

    @hash = Gmaps4rails.build_markers(@events) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
      marker.title event.title
      marker.infowindow event.title
      marker.json({
        :clickable => true,
        :center => [event.latitude, event.longitude]
      })
      marker.picture({
        :width   => 32,
        :height  => 37,
        :anchor  => [10, 10],
        :url     => view_context.image_path("#{event.category}.png")
      })
    end
    render :map
  end

  def map_with_category
    @events = Event.where(category: params[:category]).order(start_at: :desc).this_weeks.most_recent(20)
    @event_provinces = Location.joins(:events).pluck(:province).uniq
    @event_categories = Event.categories.keys - [params[:category]]

    @hash = Gmaps4rails.build_markers(@events) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
      marker.title event.title
      marker.infowindow event.title
      marker.json({
        :clickable => true,
        :center => [event.latitude, event.longitude]
      })
      marker.picture({
        :width   => 32,
        :height  => 37,
        :anchor  => [10, 10],
        :url     => view_context.image_path("#{event.category}.png")
      })
    end
    render :map
  end
end
