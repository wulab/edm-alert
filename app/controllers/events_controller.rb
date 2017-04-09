class EventsController < ApplicationController
  def index
    @events = Event.this_weeks.page(params[:page])
    set_locations
  end

  def show
    if @event = Event.find_by(id: params[:id])
      @hospitals_nearby = Hospital.near_by(@event.location.postal_code.to_i)
    end
  end

  def category
    @events = Event.by_category(params[:category]).this_weeks.page(params[:page])
    set_locations
    render :index
  end

  def location
    @events = Event.by_location(params[:location]).this_weeks.page(params[:page])
    set_locations
    render :index
  end

  def postalcode
    @events = Event.by_postalcode(params[:postalcode]).this_weeks.page(params[:page])
    @location = Location.find_by(postal_code: params[:postalcode])
    set_locations
    render :index
  end

  private
  
  def set_locations
    @event_categories = Event.categories.keys
    @event_provinces = Event.available_locations
  end
end
