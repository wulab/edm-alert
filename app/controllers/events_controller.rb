class EventsController < ApplicationController
  def index
    @events = Event.order(start_at: :desc)
    @event_categories = Event.categories.keys
    @event_provinces = Location.joins(:events).pluck(:province).uniq
  end

  def category
    @events = Event.where(category: params[:category]).order(start_at: :desc)
    @event_categories = Event.categories.keys - [params[:category]]
    @event_provinces = Location.joins(:events).pluck(:province).uniq
    render :index
  end

  def location
    @events = Event.joins(:location).where(locations: { province: params[:location] }).order(start_at: :desc)
    @event_provinces = Location.joins(:events).pluck(:province).uniq
    @event_categories = Event.categories.keys
    render :index
  end
end
