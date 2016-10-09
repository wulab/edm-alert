class PagesController < ApplicationController
  def index
    @events = Event.all
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
        :width   => 20,
        :height  => 20,
        :anchor  => [10, 10]
      })
    end
  end

  def map
    @events = Event.all
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
        :width   => 20,
        :height  => 20,
        :anchor  => [10, 10]
      })
    end
  end
end
