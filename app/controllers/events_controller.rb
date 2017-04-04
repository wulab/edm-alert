class EventsController < ApplicationController
  def index
    @events = Event.this_weeks.page(params[:page])
    @event_categories = Event.categories.keys
    @event_provinces = Event.available_locations
  end

  def show
    if @event = Event.find_by(id: params[:id])
      @hospitals_nearby = Hospital.near_by(@event.location.postal_code.to_i)
    end
  end

  def category
    @events = Event.by_category(params[:category]).this_weeks.page(params[:page])
    @event_categories = Event.categories.keys - [params[:category]]
    @event_provinces = Event.available_locations
    render :index
  end

  def location
    @events = Event.by_location(params[:location]).this_weeks.page(params[:page])
    @event_provinces = Event.available_locations
    @event_categories = Event.categories.keys
    render :index
  end

  def postalcode
    @events = Event.by_postalcode(params[:postalcode]).this_weeks.page(params[:page])
    @event_provinces = Event.available_locations
    @event_categories = Event.categories.keys
    @location = Location.find_by(postal_code: params[:postalcode])
    render :index
  end
end
