class EventsController < ApplicationController
  def index
    @events = Event.order(start_at: :desc).this_weeks.page(params[:page])
    @event_categories = Event.categories.keys
    @event_provinces = Location.joins(:events).pluck(:province).uniq
  end

  def show
    if @event = Event.find_by(id: params[:id])
      @hospitals_nearby = Hospital.where(postal_code: @event.location.postal_code.to_i)
    end
  end

  def category
    @events = Event.where(category: params[:category]).
                order(start_at: :desc).this_weeks.page(params[:page])
    @event_categories = Event.categories.keys - [params[:category]]
    @event_provinces = Location.joins(:events).pluck(:province).uniq
    render :index
  end

  def location
    @events = Event.joins(:location).
                where(locations: { province: params[:location] }).
                order(start_at: :desc).this_weeks.page(params[:page])
    @event_provinces = Location.joins(:events).pluck(:province).uniq
    @event_categories = Event.categories.keys
    render :index
  end

  def postalcode
    @events = Event.joins(:location).
                where(locations: { postal_code: params[:postalcode] }).
                order(start_at: :desc).this_weeks.page(params[:page])
    @event_provinces = Location.joins(:events).pluck(:province).uniq
    @event_categories = Event.categories.keys
    @location = Location.find_by(postal_code: params[:postalcode])
    render :index
  end
end
